class User::PhotosController < User::BaseController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :load_resources, only: [:new, :create, :edit, :update]

  def index
    @photos = current_user.photos.includes(:category).order("created_at desc")
    @gallary_type = params[:gallary_type] || "flow" 
  end

  def show
    @photo_comment = PhotoComment.new
    @photo.update_views!(current_user,request.remote_ip)
    #respond_with(@photo,layout:'user/show_photo')
  end

  def new
    @photo = Photo.new
    render :layout => "user/plan_layout"
  end

  def edit
  end

  def create
    @photo = current_user.photos.build(photo_params)
    unless @photo.save
      puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
      puts "Não salvou - #{@photo.errors.any?}"
      puts @photo.errors.full_messages
    end 
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
    @gallary_type = params[:gallary_type]
  end

  private
    def set_photo
      if params[:act]
        condition = "id #{params[:act] == "next" ? ' > ' : ' < ' } ?"
        order     = "id #{params[:act] == "next" ? ' asc ' : ' desc ' }"
        @photo = current_user.photos.where(condition,params[:id].to_i).order(order).limit(1).first
      end
      if params[:act].nil? || @photo.nil?
        @photo = current_user.photos.find(params[:id])
      end
    end

    def photo_params
      params.require(:photo).permit(:user_id, :category_id, :title, :description, :tags, :picture)
    end

    def load_resources
      @categories = Category.all
    end
end
