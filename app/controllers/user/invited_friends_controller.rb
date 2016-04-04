class User::InvitedFriendsController < User::BaseController

	def create
		@invited_friend = current_user.invited_friends.build(invited_friend_params)
		@invited_friend.save
	end

private

	def invited_friend_params
    params.require(:invited_friend).permit(:email)
  end
end
