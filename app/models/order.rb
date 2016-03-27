class Order < ActiveRecord::Base
	
	ORIGIN_WORKSHOP = 1
	ORIGIN_PORTFOLIO = 2
  
  has_many :payment_histories, class_name: "OrderPaymentHistory"
  belongs_to :user
  belongs_to :productable, polymorphic: true
  belongs_to :workshop_plan
  
  before_create :set_default_values
  after_save :create_payment_history, :create_workshop_after_paid

  def reference
    "#{self.origin == ORIGIN_WORKSHOP ? "ws-" : ""}#{self.id.to_s.rjust(6,'0')}"  
  end

  def payment_type_description
    return "-" if self.payment_type.nil?
    I18n.t("user.orders.pagseguro.payment_types")[self.payment_type]
  end

  def payment_method_description
    return "-" if self.payment_code.nil?
    I18n.t("user.orders.pagseguro.payment_methods")[self.payment_code]
  end

  def paid?
    self.status == Pagseguro::STATUS_PAID #payment_histories.where(status:Pagseguro::STATUS_PAID).first.present? 
  end

private 

  def set_default_values
  	self.status = Pagseguro::STATUS_PENDING
    self.last_status_update_at = DateTime.now
  end

  def create_payment_history
    return true unless self.last_status_update_at_changed?
    attributes = {
      status:self.status,
      status_date: self.last_status_update_at
    }
    self.payment_histories << OrderPaymentHistory.new(attributes)
  end 

  def create_workshop_after_paid
    if self.productable.nil? && self.status_changed? && self.status == Pagseguro::STATUS_PAID
      attributes = {
        user_id: self.user_id,
        workshop_plan_id: self.workshop_plan_id,
        description: self.description
      }
      workshop = Workshop.create!(attributes)
      self.productable = workshop
      self.save
      notificate_user(workshop)
    end
  end

  def notificate_user(workshop)
    i18n_key = 'notifications.workshop_paid'
    workshop_path = Rails.application.routes.url_helpers.user_workshop_path(workshop.id)
    workshop_url  = "<a href='#{workshop_path}'>#{I18n.t('activerecord.models.workshop.one')}</a>"

    order_path = Rails.application.routes.url_helpers.user_order_path(self.id)
    order_url  = "<a href='#{order_path}'> ref:#{self.reference}</a>"
    attributes = {
      content: I18n.t(i18n_key,order_ref:order_url,workshop_url:workshop_url),
      type_of: Notification::TYPE_WORKSHOP_PAYMENT_COMPLETED,
      user_sender_id: User::SYSTEM_USER,
      user_receiver_id: self.user_id,
      read:false
    }
    Notification.create!(attributes)
    User::NotificationMailer.workshop_paid_message(self).deliver_now!   
  end 
end
