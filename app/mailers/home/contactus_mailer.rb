class Home::ContactusMailer < ActionMailer::Base
  default :from => "notifications@pic2gether.com"
 
  def notificate(name, email, message)
    @name = name
    @email = email
    @message = message
    mail(:to 				=> "deivisson.bruno@gmail.com", 
    		 :subject 	=> "Contato Pic2gether",
    		 :reply_to 	=> "deivisson.bruno@gmail.com")
  end

end