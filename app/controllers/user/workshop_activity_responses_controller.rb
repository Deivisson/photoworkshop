class User::WorkshopActivityResponsesController < User::BaseController
  before_action :set_workshop, only: [:create]
  before_action :set_workshop_activity_response, only: [:show, :edit, :update, :destroy]
  before_action :load_resources, only: [:new, :create, :edit, :update]

  # def index
  #   @workshop_activity_responses = WorkshopActivityResponse.all
  #   respond_with(@workshop_activity_responses)
  # end

  # def show
  #   respond_with(@workshop_activity_response)
  # end

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
      @workshop = current_user.my_workshops.find(params[:workshop_id])
    end

    def workshop_activity_response_params
      params.require(:workshop_activity_response).permit(:activity_id, :workshop_id, 
        photo_attributes: [:picture,:title,:description,:category_id,:tags])
    end

    def load_resources
      @categories = Category.all
    end

end
