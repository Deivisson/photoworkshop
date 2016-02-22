class User::NotificationMailer < ActionMailer::Base
  default :from => "Equipe Pic2gether <team@pic2gether.com>"
 
  def change_level_message(user)
    @user = user;  @level = user.level
    mail(:to 				=> user.email, 
    		 :subject 	=> I18n.t('mailer_subjects.change_level'),
    		 :reply_to 	=> "<team@pic2gether.com>")
  end

  def photo_covered_message(user_point)
  	@user = user_point.user; @user_point = user_point
    mail(:to 				=> @user.email, 
    		 :subject 	=> I18n.t('mailer_subjects.photo_covered'),
    		 :reply_to 	=> "<team@pic2gether.com>")
  end

  def upload_increased_message(user,social_network)
    @user = user;
    @social_network = social_network;
    @profile = user.profile;

    mail(:to        => user.email, 
         :subject   => I18n.t('mailer_subjects.reward'),
         :reply_to  => "<team@pic2gether.com>")
  end
end