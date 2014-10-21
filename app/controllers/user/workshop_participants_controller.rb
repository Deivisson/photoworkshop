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
    @participant = User.find(params[:user_id])
    @workshop_participant = @workshop.workshop_participants.build(user_id:params[:user_id])
    @workshop_participant.save
    #@workshop.participants << @participant unless @participant.nil?
  end

  def remove
    @workshop_participant = @workshop.workshop_participants.where(user_id:params[:user_id]).first
    unless @workshop_participant.nil?
      @workshop_participant.destroy
    end
  end

  private

    def set_workshop
      @workshop = current_user.owner_workshops.find(params[:workshop_id])
    end

end
