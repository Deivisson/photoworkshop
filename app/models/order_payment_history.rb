class OrderPaymentHistory < ActiveRecord::Base
	validates :order_id, presence:true
	validates :status, presence:true
  belongs_to :order
	default_scope -> {order("created_at desc")} 
end
