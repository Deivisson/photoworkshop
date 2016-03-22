class User::WorkshopActivityResponsesController < User::BaseController
  before_action :set_workshop, only: [:create,:show]
  before_action :set_workshop_activity_response, only: [:edit, :update, :destroy]
  before_action :load_resources, only: [:new, :create, :edit, :update]

  # def index
  #   @workshop_activity_responses = WorkshopActivityResponse.all
  #   respond_with(@workshop_activity_responses)
  # end

  #This action is used by workshop owner to avaliate the responses by students
  def show
    @workshop_activity = @workshop.activities.where(id:params[:activity_id]).first
    @workshop_activity_response = @workshop_activity.responses.where(id:params[:id]).first
    render layout:'user/plan_layout' unless request.xhr?
  end

  def new
    attributes = {
      workshop_activity_id:params[:activity_id],
      user_id: current_user.id
    }
    @workshop_activity_response = WorkshopActivityResponse.new(attributes)
    @workshop_activity_response.build_photo
    respond_with(@workshop_activity_response, layout:false)
  end

  def edit
  end

  def create
    unless @workshop.nil?
      @workshop_activity_response = current_user.activity_responses.new(workshop_activity_response_params)
      @workshop_activity_response.workshop_activity_id = params[:activity_id]
      @workshop_activity_response.photo.user_id = current_user.id
      @workshop_activity_response.save
    end
  end

  def update
    @workshop_activity_response.update(workshop_activity_response_params)
    respond_with(@workshop_activity_response)
  end

  def destroy
    @workshop_activity_response.destroy
  end

  private

    def set_workshop_activity_response
      @workshop_activity_response = current_user.activity_responses.find(params[:id])
    end

    def set_workshop
      if action_name == "show"
        @workshop = current_user.owner_workshops.find(params[:workshop_id])
      else
        @workshop = current_user.my_workshops.find(params[:workshop_id])
      end
    end

    def workshop_activity_response_params
      params.require(:workshop_activity_response).permit(:activity_id, :workshop_id, 
        photo_attributes: [:picture,:title,:description,:category_id,:tags])
    end

    def load_resources
      @categories = Category.all
    end

end
