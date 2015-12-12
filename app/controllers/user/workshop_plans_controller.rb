class User::WorkshopPlansController < User::BaseController
	def index
		@workshop_plans = WorkshopPlan.active.order(:value)
		render layout:false
	end
end