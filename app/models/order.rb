class Order < ActiveRecord::Base
	TYPE_WORKSHOP = 1
	TYPE_PORTFOLIO = 2

	STATUS_PENDING = 0

  belongs_to :user
  belongs_to :productable

  before_create :set_initial_params


  private 

  def set_initial_params
  	self.status = STATUS_PENDING
  end
end
