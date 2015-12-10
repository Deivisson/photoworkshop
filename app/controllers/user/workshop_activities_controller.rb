class User::WorkshopActivitiesController < User::BaseController
  before_action :set_workshop
  before_action :set_workshop_activity, only: [:show, :edit, :update, :destroy]

  # def index
  #   @workshop_activities = WorkshopActivity.all
  #   respond_with(@workshop_activities)
  # end

  def show
    if (!request.xhr? || params[:responses_user_id].present? ) && current_user.id == @workshop.user_id
      @modal = false 
      @activity_responses = @workshop_activity.responses
      if params[:responses_user_id]
        @activity_responses = @activity_responses.where(user_id:params[:responses_user_id]) if params[:responses_user_id].to_i > 0
      else
        respond_with(@workshop_activity, layout:'user/workshop_activities_show')
      end
    else
      @modal = true
      respond_with(@workshop_activity, layout:false)
    end
  end

  def new
    @workshop_activity = WorkshopActivity.new
    respond_with(@workshop_activity,layout:false)
  end

  def edit
    respond_with(@workshop_activity,layout:false)
  end

  def create
    @workshop_activity = @workshop.activities.build(workshop_activity_params)
    @workshop_activity.save
  end

  def update
    @workshop_activity.update(workshop_activity_params)
  end

  def destroy
    @workshop_activity.destroy
  end

  private
    def set_workshop
      if action_name == "show"
        @workshop = Workshop.find(params[:workshop_id])
        #Only the workshop owner or workshop's participant can see the workshop and activity
        unless (@workshop.user_id == current_user.id || @workshop.participant_ids.include?(current_user.id))
          @workshop = nil
        end
      else
        @workshop = current_user.owner_workshops.find(params[:workshop_id])
      end
    end

    def set_workshop_activity
      @workshop_activity = @workshop.activities.find(params[:id])
    end

    def workshop_activity_params
      params.require(:workshop_activity).permit(:description, :details, :status, :limit_date,:maximum_upload_number)
    end
end
