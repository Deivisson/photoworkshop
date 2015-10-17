class User::FirstLoginStepsController < User::BaseController
	before_action :get_step

	def index
		current_user.update_attribute(:first_login, :false)
	end

	def step
		case @step
		when 0
			update_city
		when 1
			save_category
		when 2
		end
	end

private
	
	def get_step
		@step = 0
		@step = params[:first_login_step_id].to_i if params[:first_login_step_id].present?
		@previous_step = @step unless params[:direction].present?
	end

	def update_city
		current_user.profile.city_id = params[:profile][:city_id]
		current_user.profile.save
		@step += 1
	end

	def save_category
		current_user.categories.destroy_all
		current_user.category_ids = params[:category_ids]
		@step += 1
	end
end