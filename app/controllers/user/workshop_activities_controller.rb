class User::WorkshopActivitiesController < User::BaseController
  before_action :set_workshop
  before_action :set_workshop_activity, only: [:show, :edit, :update, :destroy]

  # def index
  #   @workshop_activities = WorkshopActivity.all
  #   respond_with(@workshop_activities)
  # end

  def show
    respond_with(@workshop_activity, layout:false)
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
        @workshop = current_user.my_workshops.find(params[:workshop_id])
      else
        @workshop = current_user.owner_workshops.find(params[:workshop_id])
      end
    end

    def set_workshop_activity
      @workshop_activity = @workshop.activities.find(params[:id])
    end

    def workshop_activity_params
      params.require(:workshop_activity).permit(:description, :details, :status, :limit_date)
    end
end
