class User::WorkshopsController < User::BaseController
  before_action :set_workshop, only: [:show, :edit, :update, :destroy, :publish,:marketing, :subscribe]

  def index
    get_index_type
    @workshops = if @type == "instructor" 
                    current_user.owner_workshops.order(created_at: :desc)
                  else
                    current_user.my_workshops.order(created_at: :desc)
                  end
  end

  def show
    # IF current user isn't the owner of workshop or not matriculated, will display a hot page
    if @workshop.mine?(current_user) || @workshop.enrolled?(current_user)
      respond_with(@workshop,layout:'user/plan_layout')
    else
      render :marketing
    end
  end


  def new
    @workshop = Workshop.new(workshop_plan_id: params[:plan_id])
    respond_with(@workshop,layout:'/user/workshop_form')
  end

  def edit
    respond_with(@workshop,layout:'/user/workshop_form')
  end

  def create
    @workshop = current_user.owner_workshops.build(workshop_params)
    if @workshop.save
      respond_with(@workshop, location:user_workshop_path(@workshop))
    else
      respond_with(@workshop)
    end
  end

  def update
    @workshop.update(workshop_params)
    respond_with(@workshop, location:user_workshop_path(@workshop))
  end

  def destroy
    @workshop.destroy
    respond_with(@workshop)
  end

  def publish
    @workshop.update_attribute(:status,Workshop::PUBLISHED)
    flash[:notice] = t('controller.workshop.published.success_on_publish')
    redirect_to user_workshop_path(@workshop)
  end

  def marketing
    respond_with(@workshop)
  end

  def subscribe
    @workshop_student = @workshop.subscribe!(current_user)
  end

  def example
    @key = params[:key]
    render layout:false
  end

  private
    def set_workshop
      id = params[:id] || params[:workshop_id]
      if ["show","marketing","subscribe"].include?(action_name)
        @workshop = Workshop.find(id)
      else
        @workshop = current_user.owner_workshops.find(id)
      end
    end

    def workshop_params
      params.require(:workshop).permit(:user_id, :description, :details, :complement, :start_date, :end_date, 
                    :vacancies_number, :value, :prerequisite, :goal, :target_audience, :term, :image,:workload,
                    :email_subscribe, :email_matriculate,:allow_queued, :allow_pre_enrolls, :workshop_plan_id)
    end

    def get_index_type
      @type = "instructor"
      if params[:type].present?
        @type = params[:type]
      else
        @type = "student" unless current_user.owner_workshops.limit(1).any?
      end
    end
end
