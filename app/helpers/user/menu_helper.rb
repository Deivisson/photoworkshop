module User::MenuHelper
	
	def gallary_button_bar(location,type,link_class)
		content_tag :li,class:(@gallary_type == type ? 'selected' : '') do
			if location == :user_photos
				link_to "", user_photos_path(gallary_type:type), remote:true,class:link_class
			elsif location == :photos_explore
				link_to "", user_photo_explore_path(gallary_type:type), remote:true,class:link_class
			end	
    end
	end

end