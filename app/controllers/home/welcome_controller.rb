class Home::WelcomeController < Home::BaseController
  
  def index
  	@photo_cover = Photo.cover
  end

  def contactus
  	@errors = []
  	@name = params["contactus"]["name"]
  	@email = params["contactus"]["email"]
  	@message = params["contactus"]["message"]

  	@errors << "Nome possui preenchimento obrigatório" unless @name.present?
  	if @email.present?
  		@errors << "Email inválido" unless @email =~ /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]+\z/i
		else
			@errors << "Email possui preenchimento obrigatório"
		end
  	@errors << "Mensagem possui preenchimento obrigatório" unless @message.present?

  	if @errors.empty?
  		Home::ContactusMailer::notificate(@name,@email,@message).deliver
		end
  end

  def termsconditions
    render layout: 'home/termsconditions'    
  end
end
