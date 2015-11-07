class User::UserProfilesController < User::BaseController
  
  before_action :set_user_profile, only: [:show, :edit, :update, :edit_cover, :update_cover_photo]
  before_action :load_resources, only: [:edit, :update]

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @user_profile.update(user_profile_params)
        format.html { redirect_to @user_profile, notice: 'User profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_profile }
      else
        format.html { render :edit }
        format.json { render json: @user_profile.errors, status: :unprocessable_entity }
        puts @user_profile.errors.full_messages
      end
    end
  end

  def social_network_shared
    current_user.profile.update_social_network_shared!(params[:provider])
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
        :tumblr,:flickr,:google_plus,:avatar, :user_name)
    end

    def load_resources
      @categories = Category.all
      @countries = Country.all
      @states = State.all
      @cities = City.limit(40)
    end    
end
