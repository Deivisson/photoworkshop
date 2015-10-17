class User::StatesController < User::BaseController

  def cities
    @cities = City.state(params[:state])
    respond_with @cities
  end

end
