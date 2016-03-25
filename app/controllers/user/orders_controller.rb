class User::OrdersController < User::BaseController
	def create
		plan = WorkshopPlan.find(params[:plan_id])
    unless plan.nil?
      attributes = {type_of:Order::TYPE_PORTFOLIO}
      @order = current_user.orders.build(attributes)
      if @order.save
        payment 								 = PagSeguro::PaymentRequest.new
        payment.reference 			 = @order.id
        payment.notification_url = api_v1_pagseguro_notifications_url
        payment.redirect_url 		 = "https://pic2gether.com/user/home"

        payment.items << {
          id: plan.id,description:plan.description,amount: plan.value
        }
        response = payment.register
        if response.errors.any?
          raise response.errors.join("\n")
        else
        	@order.update_attribute(:integration_code,response.code)
          redirect_to response.url
        end
      end
    end		
	end
end
