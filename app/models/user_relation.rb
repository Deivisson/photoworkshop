class UserRelation < ActiveRecord::Base
	validates :user_id, presence:true
	validates :user_followed_id, presence:true, uniqueness: {scope: :user_id}

  belongs_to :user
end
