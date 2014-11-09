module User::PhotosHelper
	def photo_gallary_be
		@last_style = ""
		@randon = Random.new

		html = []
		html << content_tag(:ul,class:'photos-gallery-b') do 
				get_items()
		end
		html.join.html_safe
	end

	def get_items
		html = []; count = 1
		@photos.each do |photo|
			if count == 1
				html << "<div class='style-#{@randon.rand(1..3)}'>"
				html << build_photo(photo,count)
			else
				html << build_photo(photo,count)
			end
			count += 1
			if count > 3
				html << "</div>" 
				count = 1
			end
		end
		html.join.html_safe
	end

	def build_photo(photo,i)
		html = [] 
		html << content_tag(:li,:class =>  (i == 1 ? 'bigger' : 'smaller')) do
			inner_html = []
			inner_html << link_to(user_photo_path(photo)) do
				image_tag(photo.picture.url(:medium),:class =>  (i == 1 ? 'bigger' : 'smaller'))
			end
			inner_html << content_tag(:div,class:'details') do 
				html_details = []
				html_details << image_tag(photo.user.profile.avatar.url(:thumb),class:'user-avatar')
				html_details << content_tag(:div,class:"details-content") do 
					html_content = []
					html_content << link_to(photo.user.profile.user_name, "#")
					html_content << content_tag(:p,distance_of_time_in_words(photo.created_at, Time.now))
					html_content.join.html_safe
				end
				html_details << content_tag(:div,class:"details-resume") do 
					html_resume = []
					html_resume << content_tag(:label,photo.likes_count,class:'likes')
					html_resume << content_tag(:label,photo.views,class:'views')
					html_resume.join.html_safe
				end				
				html_details.join.html_safe
			end

			inner_html.join.html_safe
		end
		html.join.html_safe
	end

	def get_style
		if @last_style == "" || @last_style == "style2"
			@style = "style1"
		else
			@style = "style2"
		end
		@last_style = @style
	end
end
