module User::PhotosHelper

	def build_gallary
		@landscape = [];	@portrait = []
		html = []
		@photos.each do |photo|
			@portrait << photo #if photo.orientation == "portrait"
			@landscape << photo #if photo.orientation == "landscape"
			if (@portrait.size + @landscape.size) == 6 || @photos.index(photo) == @photos.size
				html << content_tag(:div,class:'row') do 
					build_gallary_row.html_safe
				end
				@portrait = [];@landscape = []
				break;
			end

		end
		html.join.html_safe
	end

	def build_gallary_row()
		return row_2l_2p
		# if l == 1 && p == 0 

		# elsif l == 0 && p == 1

		# elsif l == 1 && p == 1

		# elsif l == 2 && p == 0
		
		# elsif l == 0 && p == 2

		# elsif l == 1 && p == 2

		# elsif l == 2 && p == 1

		# elsif l == 3 && p == 0
		
		# elsif l == 0 && p == 3

		# elsif l == 1 && p == 3  

		# elsif l == 2 && p == 2

		# elsif l == 3 && p == 1

		# elsif l == 4 && p == 0

		# elsif l == 0 && p == 4
		
		# end
	end

	def row_1l_3p
		html = content_tag(:div,class:"row") do 
			cols = 2.times.collect{|i| picture_col("col40") {image_factory(@portrait[i], "h100")} }
			cols << picture_col("col20") do 
				pics = []
				pics << image_factory(@portrait.last, "h60 w100")
				pics << image_factory(@landscape.first, "h30 w100 top50")
				pics.join.html_safe
		 	end
		 	cols.join.html_safe
		end
		html.html_safe
	end


	def row_2l_2p
		html = content_tag(:div,class:"row") do 
			cols = 2.times.collect{|i| picture_col("col33") {image_factory(@portrait[i], "h100")} }
			cols << picture_col("col33") do 
				2.times.collect{|i| image_factory(@landscape[i], "h50")}.join.html_safe
		 	end
		 	cols.join.html_safe
		end
		html.html_safe
	end  


	def row_2l_2p_b
		html = content_tag(:div,class:"row") do 
			cols = []
			cols << picture_col("col33") do 
				2.times.collect{|i| image_factory(@landscape[i], "h50")}.join.html_safe
		 	end
		 	2.times{|i| cols << picture_col("col33") {image_factory(@portrait[i], "h100")} }
		 	cols.join.html_safe
		end
		html.html_safe
	end


	def row_3l_1p
		html = content_tag(:div,class:"row") do
			cols = []
			cols << picture_col("col25") do 
				2.times.collect{|i| image_factory(@landscape[i], "h50")}.join.html_safe
		 	end
		 	cols << picture_col("col50") {image_factory(@landscape.last, "h100")}
		 	cols << picture_col("col25 last-col") {image_factory(@portrait.first, "h100")}
		 	cols.join.html_safe
		end
		html.html_safe

	end


	def row_4l_0p
		html = content_tag(:div,class:"row") do
			cols = []
			cols << picture_col("col50") {image_factory(@landscape.first, "h100")}
			cols << picture_col("col50 last-col") do 
				pics = []
				pics << image_factory(@landscape.second, "h60")
				2.times{|i| pics << image_factory(@landscape[i+2], "w50 h30")}
				pics.join.html_safe
		 	end
		 	cols.join.html_safe
		end
		html.html_safe
	end





	def picture_col(class_name, &block)
		html = content_tag(:div,class:"col #{class_name}") do 
			inner_html = content_tag(:nil, &block)
			inner_html.html_safe
		end
		html.html_safe	
	end

	def image_factory(photo,class_name="")
		return if photo.nil?
		html = content_tag(:div,class:"img-container #{class_name}") do 
			inner_html = []
			inner_html << content_tag(:div,"",class:"img-pic", style:"background-image: url('#{photo.picture.url(:medium)}')");
			inner_html << content_tag(:div,"",class:"img-info")
			inner_html.join.html_safe
		end
		html.html_safe
	end






















	# def row_3l_1p
	# 	html = []
	# 	html << content_tag(:li, class:'photo-item-container', style: "width:25%") do
	# 		html_item = []
	# 		2.times do |i|
	# 			html_item << content_tag(:li, class:'photo-item-container', style: "width:100%;height:50%") do
	# 				html_photo << build_url(@landscape[i])
	# 				html_photo << photo_info_to_gallary_grid(@landscape[i])
	# 				html_photo << photo_flow_counts(@landscape[i])
	# 				html_photo.join.html_safe
	# 			end
	# 		end
	# 	end
	# 	html << content_tag(:li, class:'photo-item-container', style: "width:50%") do
	# 		html_item = []
	# 		html_item << build_url(@portrait.first)
	# 		html_item << photo_info_to_gallary_grid(@portrait.first)
	# 		html_item << photo_flow_counts(@portrait.first)
	# 		html_item.join.html_safe
	# 	end
	# 	html << content_tag(:li, class:'photo-item-container', style: "width:25%") do
	# 		html_item = []
	# 		html_item << build_url(@landscape.last)
	# 		html_item << photo_info_to_gallary_grid(@landscape.last)
	# 		html_item << photo_flow_counts(@landscape.last)
	# 		html_item.join.html_safe
	# 	end
	# 	html.join.html_safe
	# end


	# def row_4l_0p
	# 	html = []
	# 	html << content_tag(:li, class:'photo-item-container', style: "width:50%") do
	# 		html_item = []
	# 		html_item << build_url(photo)
	# 		html_item << photo_info_to_gallary_grid(photo)
	# 		html_item << photo_flow_counts(photo)
	# 		html_item.join.html_safe
	# 	end
	# 	html << content_tag(:li, class:'photo-item-container', style: "width:50%") do
	# 		html_item = []
	# 		html_item << build_url(photo)
	# 		html_item << photo_info_to_gallary_grid(photo)
	# 		html_item << photo_flow_counts(photo)
	# 		html_item.join.html_safe
	# 	end
	# end

	# def row_2l_2p
	# 	html = []
	# 	2.times do |i|
	# 		html << content_tag(:div, class:'photo-item-container portrait33') do
	# 			html_item = []
	# 			html_item << build_url(@portrait[i])
	# 			html_item << photo_info_to_gallary_grid(@portrait[i])
	# 			html_item << photo_flow_counts(@portrait[i])
	# 			html_item.join.html_safe
	# 		end
	# 	end
	# 	html << content_tag(:div, class:'photo-item-container',style:"width:32%;") do
	# 		html_item = []
	# 		2.times do |i|
	# 			html_item << content_tag(:div,class:'2lands',style:'width:100%;height:50%') do
	# 				html_photo = []
	# 				html_photo << build_url(@landscape[i])
	# 				html_photo << photo_info_to_gallary_grid(@landscape[i])
	# 				html_photo << photo_flow_counts(@landscape[i])
	# 				html_photo.join.html_safe		
	# 			end
	# 		end
	# 		html_item.join.html_safe
	# 	end
	# end

	# def row_2l_2p_b
	# 	html = []
	# 	html << content_tag(:li, class:'photo-item-container', style: "width:33.33%") do
	# 		html_item = []
	# 		html_item << build_url(photo)
	# 		html_item << photo_info_to_gallary_grid(photo)
	# 		html_item << photo_flow_counts(photo)
	# 		html_item.join.html_safe
	# 	end
	# 	html << content_tag(:li, class:'photo-item-container', style: "width:33.33%") do
	# 		html_item = []
	# 		html_item << build_url(photo)
	# 		html_item << photo_info_to_gallary_grid(photo)
	# 		html_item << photo_flow_counts(photo)
	# 		html_item.join.html_safe
	# 	end
	# 	html << content_tag(:li, class:'photo-item-container', style: "width:33.33%") do
	# 		html_item = []
	# 		html_item << build_url(photo)
	# 		html_item << photo_info_to_gallary_grid(photo)
	# 		html_item << photo_flow_counts(photo)
	# 		html_item.join.html_safe
	# 	end
	# end


	# def row_1l_3p
	# 	html = []
	# 	html << content_tag(:li, class:'photo-item-container', style: "width:40%") do
	# 		html_item = []
	# 		html_item << build_url(photo)
	# 		html_item << photo_info_to_gallary_grid(photo)
	# 		html_item << photo_flow_counts(photo)
	# 		html_item.join.html_safe
	# 	end
	# 	html << content_tag(:li, class:'photo-item-container', style: "width:40%") do
	# 		html_item = []
	# 		html_item << build_url(photo)
	# 		html_item << photo_info_to_gallary_grid(photo)
	# 		html_item << photo_flow_counts(photo)
	# 		html_item.join.html_safe
	# 	end
	# 	html << content_tag(:li, class:'photo-item-container', style: "width:20%") do
	# 		html_item = []
	# 		html_item << build_url(photo)
	# 		html_item << photo_info_to_gallary_grid(photo)
	# 		html_item << photo_flow_counts(photo)
	# 		html_item.join.html_safe
	# 	end
	# end


	# def row_4l_0p
	# 	html = []
	# 	html << content_tag(:li, class:'photo-item-container', style: "width:75%") do
	# 		html_item = []
	# 		html_item << build_url(photo)
	# 		html_item << photo_info_to_gallary_grid(photo)
	# 		html_item << photo_flow_counts(photo)
	# 		html_item.join.html_safe
	# 	end
	# 	html << content_tag(:li, class:'photo-item-container', style: "width:25%") do
	# 		html_item = []
	# 		html_item << build_url(photo)
	# 		html_item << photo_info_to_gallary_grid(photo)
	# 		html_item << photo_flow_counts(photo)
	# 		html_item.join.html_safe
	# 	end
	# end

	# def row_3l_1p
	# 	html = []
	# 	html << content_tag(:li, class:'photo-item-container', style: "width:25%") do
	# 		html_item = []
	# 		html_item << build_url(photo)
	# 		html_item << photo_info_to_gallary_grid(photo)
	# 		html_item << photo_flow_counts(photo)
	# 		html_item.join.html_safe
	# 	end
	# 	html << content_tag(:li, class:'photo-item-container', style: "width:50%") do
	# 		html_item = []
	# 		html_item << build_url(photo)
	# 		html_item << photo_info_to_gallary_grid(photo)
	# 		html_item << photo_flow_counts(photo)
	# 		html_item.join.html_safe
	# 	end
	# 	html << content_tag(:li, class:'photo-item-container', style: "width:25%") do
	# 		html_item = []
	# 		html_item << build_url(photo)
	# 		html_item << photo_info_to_gallary_grid(photo)
	# 		html_item << photo_flow_counts(photo)
	# 		html_item.join.html_safe
	# 	end		
	# end



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
			# html << link_to(photo.user.profile.user_name,
			# 								user_photographer_path(photo.user_id),
			# 								class:"photographer-profile") if @location != :user_photos
			# html << content_tag(:h6,photo.title.truncate(30))
			if @location == :photos_explore
				html << link_to(photo.user.profile.user_name,user_photographer_path(photo.user_id),
				 												class:"photographer-profile") #photographers name
			elsif @location == :user_photos
				html << content_tag(:h5,photo.title.truncate(30))
			end
			html << content_tag(:h6,distance_of_time_in_words(photo.created_at, Time.now))			
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
				if @location == :photos_explore
					html_content << link_to(photo.user.profile.user_name,user_photographer_path(photo.user_id),
					 												class:"photographer-profile") #photographers name
				elsif @location == :user_photos
					html_content << content_tag(:label,photo.title,class:"photo-title")
				end
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
		html = ""
		# if @location == :user_photos
		# 	link_to(image_tag(photo.picture.url(:medium)), 
		# 					user_photo_path(photo), class:'photo-picture')
		# elsif @location == :photos_explore
			#link_to(image_tag(photo.picture.url(:medium)), user_photo_explore_show_path(photo), class:'photo-picture')
		return content_tag(:div, "",class:"photo-image",style:"background-image:url(#{photo.picture.url(:medium)})") 
		# end
	end

end
