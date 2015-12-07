class User::PhotoRatingsController < User::BaseController
	before_action :set_photo
	before_action :set_activity_response

	def index
		@rating_criteriums = RatingCriterium.all
		render layout:false
	end

	def save
		current_user.photo_ratings.where(photo_id:@photo.id).destroy_all
		photo_attributes = photo_comment.merge!(user_id: current_user.id)
		@photo.comments << PhotoComment.new(photo_attributes) if photo_attributes["content"].present?
		photo_rating_params.each do |pr|
			current_user.photo_ratings << PhotoRating.new(pr)
		end
	end

private 

	def set_photo
		@photo = Photo.find(params[:photo_id])		
	end

	def photo_rating_params
   	params.require(:photo_ratings).map do |r|
   		ActionController::Parameters.new(r.to_hash).permit(:rating_criterium_id, :photo_id, :score)
   	end
  end

  def photo_comment
  	params.require(:photo_comment).permit(:content,:from_workshop_activity)
  end

  def set_activity_response
  	@workshop_activity_response = WorkshopActivityResponse.find(params["response_id"])
  end
end

