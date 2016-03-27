class Pagseguro < ActiveRecord::Base
	#Types
	PAYMENTS = 1
	SIGNATURE = 11

	#status
	STATUS_PENDING = 0
  STATUS_WAITING_PAYGMENT = 1
  STATUS_IN_ANALYSIS = 2
  STATUS_PAID = 3
  STATUS_AVAILABLE = 4
  STATUS_IN_DISPUTE = 5
  STATUS_BOUNCED = 6
  STATUS_CANCELED = 7
  STATUS_DEBITED = 8
  STATUS_WITHHELD = 9

	# #Payment Type
	# CREDIT_CARD = 1
	# BILLET = 2
	# ONLINE_DEBT = 3
	# PAGSEGURO = 4
	# OI_PAGGO = 5
	# DEPOSIT_ACCOUNT = 6

	# PAYMENT_TYPES = [
	# 	:credit_card,:billet,:online_debt,:pagseguro,:oi_paggo,:deposit_account
	# ]
	def self.status_title(status)
    if [Pagseguro::STATUS_IN_DISPUTE,Pagseguro::STATUS_AVAILABLE].include?(status)
      I18n.t("user.orders.pagseguro.status")[Pagseguro::STATUS_PAID][:title]
    else
      I18n.t("user.orders.pagseguro.status")[status][:title]
    end
  end
  
  def self.status_description(status)
    if [Pagseguro::STATUS_IN_DISPUTE,Pagseguro::STATUS_AVAILABLE].include?(status)
      I18n.t("user.orders.pagseguro.status")[Pagseguro::STATUS_PAID][:description]
    else
      I18n.t("user.orders.pagseguro.status")[status][:description]
    end
  end	
end