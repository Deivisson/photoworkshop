class User::WorkshopsController < User::BaseController
  
  before_action :set_workshop, only: [:show, :edit, :update, :destroy, :open]

  def index
    @workshops = current_user.owner_workshops
    respond_with(@workshops)
  end

  def show
    respond_with(@workshop)
  end

  def new
    @workshop = Workshop.new
    respond_with(@workshop)
  end

  def edit

  end

  def create
    @workshop = current_user.owner_workshops.build(workshop_params)
    @workshop.save
    respond_with(@workshop, location:user_workshop_path(@workshop))
  end

  def update
    @workshop.update(workshop_params)
    respond_with(@workshop, location:user_workshop_path(@workshop))
  end

  def destroy
    @workshop.destroy
    respond_with(@workshop)
  end

  def open
    @workshop.update_attribute(:status,Workshop::OPENED)
    flash[:notice] = t('.controller.workshop.open.success_on_open')
    redirect_to user_workshop_path(@workshop)
  end

  private
    def set_workshop
      id = params[:id] || params[:workshop_id]
      @workshop = current_user.owner_workshops.find(id)
    end

    def workshop_params
      params.require(:workshop).permit(:user_id, :description, :details, :start_date, :end_date, :vacancies_number, :value, :prerequisite, :goal, :target_audience, :term, :image)
    end
end
