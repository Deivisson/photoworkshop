class Level < ActiveRecord::Base
	validates :i18n_key, presence:true, uniqueness:true

	attr_accessor :user_current_points

	def self.by_user(user)
		level = where("? between points_from and points_to", user.current_points + 1).first
		level.user_current_points = user.current_points unless level.nil?
		level
	end

	def description
		I18n.t(self.i18n_key)
	end

	def info
		I18n.t("#{self.i18n_key}_info")
	end

	def points_to_next_level
		self.points_to - user_current_points
	end

	def points_current_level
		(user_current_points  - self.points_from) + 1
	end


	#Ex.: 
	# Indicate how many points is necessary win to move to the next level
	# => points_from: 101
	# => points_to  : 200
	# => goal 			: 200 - 101 = 99  
	def points_goal_for_current_level
		self.points_to - self.points_from + 1
	end

	def progress_label
		"#{points_current_level}/#{points_goal_for_current_level}"
	end

	def progress_label_with_label
		"#{points_current_level} / #{points_goal_for_current_level} (#{description})"
	end

	def progress_perc
		points_current_level.to_f / points_goal_for_current_level.to_f * 100
	end
end
