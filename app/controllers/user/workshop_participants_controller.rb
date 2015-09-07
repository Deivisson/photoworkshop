class User::WorkshopParticipantsController < User::BaseController
  before_action :set_workshop

  def index
    @user_profiles = []
    if params[:conditions].present?
      @participant_ids = @workshop.participant_ids

      @user_profiles = UserProfile.includes(:city)
      @user_profiles = @user_profiles.where("user_name ~* ? ",params[:conditions])
      @user_profiles = @user_profiles.where("user_id <> ? ",current_user.id)
    end
    render layout:false
  end

  def add
    if current_user.id == @workshop.user_id
      @participant = User.find(params[:user_id])
      @workshop_participant = @workshop.workshop_participants.build(user_id:params[:user_id])
      @workshop_participant.confirmed = true
      @workshop_participant.save
    end
  end

  def remove
    @workshop_participant = @workshop.workshop_participants.where(user_id:params[:user_id]).first
    unless @workshop_participant.nil?
      @workshop_participant.destroy
    end
  end

  def confirm_matriculation
    @workshop_participant = @workshop.workshop_participants.where(user_id:params[:user_id]).first
    unless @workshop_participant.nil?
      @workshop_participant.update_attribute(:confirmed,true)
      flash[:notice] = t('controller.workshop.open.success_on_open')
    end
  end

  private

    def set_workshop
      @workshop = current_user.owner_workshops.find(params[:workshop_id])
    end

end
