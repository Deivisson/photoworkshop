class User::WorkshopActivitiesController < User::BaseController
  before_action :set_workshop_activity, only: [:show, :edit, :update, :destroy]

  # def index
  #   @workshop_activities = WorkshopActivity.all
  #   respond_with(@workshop_activities)
  # end

  # def show
  #   respond_with(@workshop_activity)
  # end

  def new
    @workshop_activity = WorkshopActivity.new
    respond_with(@workshop_activity)
  end

  def edit; end

  def create
    @workshop_activity = WorkshopActivity.new(workshop_activity_params)
    @workshop_activity.save
    respond_with(@workshop_activity)
  end

  def update
    @workshop_activity.update(workshop_activity_params)
    respond_with(@workshop_activity)
  end

  def destroy
    @workshop_activity.destroy
    respond_with(@workshop_activity)
  end

  private
    def set_workshop_activity
      @workshop_activity = WorkshopActivity.find(params[:id])
    end

    def workshop_activity_params
      params.require(:workshop_activity).permit(:description, :details, :status, :limit_date)
    end
end
