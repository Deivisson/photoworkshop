class User::UsersController < User::BaseController
	
	# def following
	# end
	# def followers
	# end
	def reset_unseen_notifications_count
		current_user.update_column(:unseen_notifications_count, 0)
	end	

	def reset_unseen_messages_count
		current_user.update_column(:unseen_messages_count, 0)
	end	
end