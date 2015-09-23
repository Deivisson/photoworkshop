class Home::WelcomeController < Home::BaseController
  def index
  	@photo_cover = Photo.cover
  end
end
