class User::UserProfilesController < User::BaseController
  
  before_action :set_user_profile, only: [:show, :edit, :update, :edit_cover, :update_cover_photo]
  before_action :load_resources, only: [:edit, :update]

  def show; end

  def edit; end

  def update
    @user_profile.update(user_profile_params)
    respond_with(@user_profile)
  end

  def social_network_shared
    current_user.profile.update_social_network_shared!(params[:provider])
  end

  def workshop_wait
    p = current_user.profile
    p.workshop_wait = true
    p.save
  end

  def edit_cover_photo
    @photos = current_user.photos.limit(30)
    @gallary_type = :table
    render layout:false
  end

  def update_cover_photo
    @photo = Photo.find(params[:photo_id])
    unless @photo.nil?
      @user_profile.update_attribute(:cover_photo_id,@photo.id)
    end
  end

  private

    def set_user_profile
      @user_profile = current_user.profile
    end

    def user_profile_params
      params.require(:user_profile).permit(:category_id, :description, :work, 
        :country_id, :state_id, :city_id, :camera, :home_page, :facebook,:twitter,
        :tumblr,:flickr,:google_plus,:avatar, :user_name, :full_name)
    end

    def load_resources
      @categories = Category.all
      @countries = Country.all
      @states = State.all
      @cities =  @user_profile.state_id.nil? ? [] : City.state(@user_profile.state_id)
    end    
end
