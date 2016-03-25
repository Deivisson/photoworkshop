class Api::V1::PagseguroNotificationsController < ApplicationController
	skip_before_filter :verify_authenticity_token, only: :create
	before_filter :cors_set_access_control_headers

	def create
		puts "passei aqui"
		puts "nf code #{params[:notificationCode]}"																												
		transaction = PagSeguro::Transaction.find_by_code(params[:notificationCode])
	 	if transaction.errors.empty?
	 		puts transaction.methods.sort
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