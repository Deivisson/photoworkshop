class Order < ActiveRecord::Base
	
	ORIGIN_WORKSHOP = 1
	ORIGIN_PORTFOLIO = 2
  
  has_many :payment_histories, class_name: "OrderPaymentHistory"
  belongs_to :user
  belongs_to :productable, polymorphic: true
  belongs_to :workshop_plan
  
  before_create :set_initial_params
  after_save :create_payment_history, :create_workshop_on_paid

  def payment_type_description
    return "-" if self.payment_type.nil?
    I18n.t("user.orders.pagseguro.payment_types")[self.payment_type]
  end

  def payment_method_description
    return "-" if self.payment_code.nil?
    I18n.t("user.orders.pagseguro.payment_methods")[self.payment_code]
  end

  def paid?
    self.payment_histories.where(status:Pagseguro::STATUS_PAID).first.present? 
  end

private 

  def set_initial_params
  	self.status = Pagseguro::STATUS_PENDING
  end

  def create_payment_history
    return true unless self.last_status_update_at_changed?
    attributes = {
      status:self.status,
      status_date: self.last_status_update_at
    }
    self.payment_histories << OrderPaymentHistory.new(attributes)
  end 

  def create_workshop_on_paid
    if self.productable.nil? && self.status_changed? && self.status == Pagseguro::STATUS_PAID
      attributes = {
        user_id: self.user_id,
        workshop_plan_id: self.workshop_plan_id,
        description: self.description
      }
      workshop = Workshop.create!(attributes)
      self.productable = workshop
      self.save
    end
   end 
end
