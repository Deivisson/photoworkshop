class User::UserProfilesController < User::BaseController
  
  before_action :set_user_profile, only: [:show, :edit, :update]
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
      end
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
