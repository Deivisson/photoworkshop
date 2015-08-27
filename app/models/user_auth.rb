class UserAuth < ActiveRecord::Base
	validates :user_id, presence:true
	validates :provider, presence:true
	validates :uid, presence:true

	belongs_to :user
	attr_accessor :account_url

	after_create :update_account_url

private
	def update_account_url
		profile = UserProfile.where(user_id:user_id).first
		unless profile.nil?
			if provider == "twitter"
				profile.twitter = account_url
			elsif provider == "facebook"
				profile.facebook = account_url 
			end
			profile.save
		end
	end
end
