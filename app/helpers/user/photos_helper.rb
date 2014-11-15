module User::PhotosHelper

	# PHOTO GALLARY FLOW. Show pictures in specifics layout style
	# The style will be defined by a randon styles that can be:
	# style-1: An big landscape image on the left and two others landscape smaller on the right side
	# style-2: An big landscape image on the right and two others landscape smaller on the left side
	# style-3: Three portrait images side-by-side with the same width
	# Example:
	#     <%= gallary_flow %>
	#
	def gallary_flow(location)
		@last_style = ""; @location = location
		@randon = Random.new
		html = []
		html << content_tag(:ul,class:'photos-gallery-flow') do 
			photos_collection_for_gallary_flow
		end
		html.join.html_safe
	end


	# PHOTO GALLARY GRID and PHOTO GALLARY FLOW GRID. Show pictures in an grid format.
	# Can be with the same size(Grid) or absolute size(flow grid)
	# For the absolute grid, the parameters "absolute_grid" should be true
	# Example:
	#     <%= gallary_flow %> #for an normal grid
	#     or 
	#			<%= gallary_flow true %> #for an flow grid 
	#
	def gallary_grid(location,flow_grid=false)
		html = [];@location = location
		html << content_tag(:ul, class:'photos-gallery-grid') do
			inner_html = []
	  	@photos.each do |photo|
	  		inner_html << content_tag(:li,class:'photo-item-container',style: flow_grid ? 'width:auto' : '') do
					html_item = []
					html_item << build_url(photo)
					html_item << photo_info_to_gallary_grid(photo)
  				html_item << photo_flow_counts(photo)
					html_item.join.html_safe
	   		end
	  	end
	  	inner_html.join.html_safe
		end
		html.join.html_safe
	end


	# PHOTO GALLARY LIST. Show pictures by list
	# Example:
	#     <%= gallary_list %>
	#	
	def gallary_list(location)
		html = []; @location = location
		html << content_tag(:ul, class:'photos-gallery-list') do
			photos_collection_for_list_gallary
		end
		html.join.html_safe
	end


private 

	def photos_collection_for_gallary_flow
		html = []; count = 1
		@photos.each do |photo|
			if count == 1
				html << "<div class='style-#{@randon.rand(1..3)}'>"
				html << build_photo(photo,'bigger')
			else
				html << build_photo(photo,'smaller')
			end
			count += 1
			if count > 3
				html << "</div>" 
				count = 1
			end
		end
		html.join.html_safe
	end

	def photo_info_to_gallary_grid(photo)
		content_tag(:div,class:'fix-info') do 
			html = []
			html << content_tag(:h5,photo.title.truncate(30))
			html << content_tag(:h6,photo.category.description.truncate(30))
			html.join.html_safe
		end.html_safe
	end
 
	def photo_flow_counts(photo)
		content_tag(:div,class:"gallery-photo-info") do
			html_info = []
			html_info << content_tag(:div,class:'info-item') do 
				html_info_item = []
				html_info_item << content_tag(:span,"Visualizacoes")
				html_info_item << content_tag(:h1, photo.views)
				html_info_item.join.html_safe
			end
			html_info << content_tag(:div,class:'info-item') do 
				html_info_item = []
				html_info_item << content_tag(:span,"Curtidas")
				html_info_item << content_tag(:h1, photo.likes_count)
				html_info_item.join.html_safe
			end
			html_info.join.html_safe
		end.html_safe
	end

	#Build a Photo and details tags for gallary list and gallary grid
	def build_photo(photo, class_name)
		html = [] 
		html << content_tag(:li,class:class_name) do
			inner_html = []
			# inner_html << link_to(user_photo_path(photo),class:'photo-picture') do
			# 	image_tag(photo.picture.url(:original))
			# end
			inner_html << build_url(photo)
			inner_html << photo_details(photo)
			inner_html.join.html_safe
		end
		html.join.html_safe
	end

	def photo_details(photo)
		content_tag(:div,class:'details') do 
			html_details = []
			html_details << image_tag(photo.user.profile.avatar.url(:thumb),class:'user-avatar')
			html_details << content_tag(:div,class:"details-content") do 
				html_content = []
				html_content << link_to(photo.user.profile.user_name,user_photographer_path(photo.user_id),
																class:"photographer-profile") #photographers name
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
		end.html_safe
	end

	def photos_collection_for_list_gallary
		html = []
		@photos.each do |photo|
			html << content_tag(:div,class:"style-1",style:"height:auto") do
				inner_html = []
				inner_html << build_photo(photo,photo.portrait? ? 'portrait' : 'landscape' )
				inner_html.join.html_safe
			end
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

	def build_url(photo)
		if @location == :user_photos
			link_to(image_tag(photo.picture.url(:medium)), 
							user_photo_path(photo), class:'photo-picture')
		elsif @location == :photos_explore
			link_to(image_tag(photo.picture.url(:medium)), 
							user_photo_explore_show_path(photo), class:'photo-picture')
		end		
	end

end
