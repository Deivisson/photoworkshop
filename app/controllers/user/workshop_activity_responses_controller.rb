class User::WorkshopActivityResponsesController < User::BaseController
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
    @workshop_activity_response = WorkshopActivityResponse.new
    @workshop_activity_response.photos.build
    respond_with(@workshop_activity_response, layout:false)
  end

  def edit
  end

  def create
    @workshop_activity_response = current_user.activity_responses.new(workshop_activity_response_params)
    @workshop_activity_response.workshop_activity_id = params[:activity_id]
    @workshop_activity_response.photos.each{|item| item.user_id = current_user.id}
    @workshop_activity_response.save
    respond_with(@workshop_activity_response)
  end

  def update
    @workshop_activity_response.update(workshop_activity_response_params)
    respond_with(@workshop_activity_response)
  end

  def destroy
    @workshop_activity_response.destroy
    respond_with(@workshop_activity_response)
  end

  private
    def set_workshop_activity_response
      @workshop_activity_response = WorkshopActivityResponse.find(params[:id])
    end

    def workshop_activity_response_params
      params.require(:workshop_activity_response).permit(:activity_id, :workshop_id, 
        photos_attributes: [:picture,:title,:description,:category_id,:tags])
    end

    def load_resources
      @categories = Category.all
    end

end
