class User::PhotosController < User::BaseController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :load_resources, only: [:new, :create, :edit, :update]

  def index
    @photos = current_user.photos
  end

  def show
  end

  def new
    @photo = Photo.new
  end

  def edit
  end

  def create
    @photo = current_user.photos.build(photo_params)
    @photo.save
    respond_with(@photo, location:user_photos_path)
  end

  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def photo_params
      params.require(:photo).permit(:user_id, :category_id, :title, :description, :tags, :picture)
    end

    def load_resources
      @categories = Category.all
    end
end
