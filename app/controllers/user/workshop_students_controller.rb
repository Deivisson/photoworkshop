class User::WorkshopStudentsController < User::BaseController
  before_action :set_workshop

  def index
    @user_profiles = []
    if params[:conditions].present?
      @student_ids = @workshop.student_ids

      @user_profiles = UserProfile.includes(:city)
      @user_profiles = @user_profiles.where("user_name ~* ? ",params[:conditions])
      @user_profiles = @user_profiles.where("user_id <> ? ",current_user.id)
    end
    render layout:false
  end

  def add
    if current_user.id == @workshop.user_id
      @student = User.find(params[:user_id])
      @workshop_student = @workshop.workshop_students.build(user_id:params[:user_id])
      @workshop_student.confirmed = true
      @workshop_student.save
    end
  end

  def remove
    @workshop_student = @workshop.workshop_students.where(user_id:params[:user_id]).first
    unless @workshop_student.nil?
      @workshop_student.destroy
    end
  end

  def confirm_matriculation
    @workshop_student = @workshop.workshop_students.where(user_id:params[:user_id]).first
    unless @workshop_student.nil?
      @workshop_student.confirm_matriculation #update_attribute(:confirmed,true)
    end
  end

  private

    def set_workshop
      @workshop = current_user.owner_workshops.find(params[:workshop_id])
    end

end
