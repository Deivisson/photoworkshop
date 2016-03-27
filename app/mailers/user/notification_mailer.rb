class User::NotificationMailer < ActionMailer::Base
  helper :application
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

  def workshop_paid_message(order)
    @order = order
    mail(:to        => @order.user.email, 
         :subject   => I18n.t('mailer_subjects.workshop_paid'),
         :reply_to  => "<team@pic2gether.com>")
  end
end