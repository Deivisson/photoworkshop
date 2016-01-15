class User::WorkshopMailer < ActionMailer::Base
  default :from => "team@pic2gether.com"
 
  def subscribe_message(workshop, user)
    @user = user;  @workshop = workshop
    mail(:to 				=> user.email, 
    		 :subject 	=> I18n.t('user.workshops.subscribe_email_subject'),
    		 :reply_to 	=> @workshop.user.email)
  end

  def matriculated_message(workshop, user)
  	@user = user;  @workshop = workshop
    mail(:to 				=> user.email, 
				 :subject 	=> I18n.t('user.workshops.matriculated_email_subject'),
				 :reply_to 	=> @workshop.user.email)
  end

end