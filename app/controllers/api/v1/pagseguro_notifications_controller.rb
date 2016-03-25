class Api::V1::PagseguroNotificationsController < ApplicationController
	skip_before_filter :verify_authenticity_token, only: :create
	before_filter :cors_set_access_control_headers

	def create
		transaction = PagSeguro::Transaction.find_by_notification_code(params[:notificationCode])
	 	if transaction.errors.empty?
	 		order = Order.find(transaction.reference)
	 		unless order.nil?
	 			order.integration_code = transaction.code
	 			order.status 					 = transaction.status.id
	 			order.type_of					 = transaction.type_id
	 			order.save
	 		end
	 		#puts transaction.methods.sort
      # Processa a notificação. A melhor maneira de se fazer isso é realizar
      # o processamento em background. Uma boa alternativa para isso é a
      # biblioteca Sidekiq.
    else
    	puts transaction.errors.to_json
    end
		render nothing: true, status: 200
	end


	def cors_set_access_control_headers
		headers['Access-Control-Allow-Origin'] = 'https://sandbox.pagseguro.uol.com.br'
	end

end