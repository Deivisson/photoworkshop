module User::PhotosHelper

	def photo_gallery(location, show_details=true, show_grid_style_options=true, options={})
		@location = location; 
		@show_details = show_details
		@photo_size = options[:photo_size] || :medium

		case @gallary_type.to_sym
		when :list
			content = content_tag(:div, class:'grid-list'){list_grid}
		when :table
			content = content_tag(:div, class:'grid-table photo-explore-container'){table_grid}
		else 
			content = content_tag(:div, class:'grid-flow photo-explore-container'){flow_grid}
		end

		html = []
		content_tag(:div,class:'photo-gallary',style:'min-width: 900px;') do 
			html << content
			html << options_grid_style if show_grid_style_options
			html.join.html_safe
		end
	end

	def list_grid
		items = []
		@photos.each do |photo|
			items << image_factory(photo)
		end
		items.join.html_safe
	end

	def table_grid
		items = []
		@photos.each do |photo|
			items << image_factory(photo)
		end
		items.join.html_safe
	end

	def flow_grid
		@landscape = [];	@portrait = []
		html = []
		@photos.each do |photo|
			@portrait << photo if photo.orientation == "portrait"
			@landscape  << photo if photo.orientation == "landscape"
			if (@portrait.size + @landscape.size) == 4 || (@photos.index(photo) == @photos.size - 1)
				html << content_tag(:div,class:'row') do 
					build_gallary_row.html_safe
				end
				@portrait = [];@landscape = []
			end
		end
		html.join.html_safe
	end

	def build_gallary_row()
		l = @landscape.size;	p = @portrait.size
		if l == 1 && p == 0 
			layout = ["row_4l_0p_3","row_4l_0p_6"]
		elsif l == 0 && p == 1
			layout = ["row_2l_2p_4","row_1l_3p_5","row_3l_1p_7","row_0l_4p_11"]
		elsif l == 1 && p == 1
			layout = ["row_3l_1p_7"]
		elsif l == 2 && p == 0
			layout = ["row_4l_0p_6"]
		elsif l == 0 && p == 2
			layout = ["row_2l_2p_4","row_1l_3p_5","row_0l_4p_11"]
		elsif l == 1 && p == 2
			layout = ["row_2l_2p_4","row_1l_3p_5"]			
		elsif l == 2 && p == 1
			layout = ["row_3l_1p_7","row_2l_2p_9"]			
		elsif l == 3 && p == 0
			layout = ["row_4l_0p_3","row_3l_1p_1","row_4l_0p_6"]			
		elsif l == 0 && p == 3
			layout = ["row_0l_4p_11"]
		elsif l == 1 && p == 3  
			layout = ["row_1l_3p_5","row_1l_3p_10"]
		elsif l == 2 && p == 2
			layout = ["row_2l_2p_4","row_2l_2p_9"]
		elsif l == 3 && p == 1
			layout = ["row_3l_1p_1","row_3l_1p_7"]
		elsif l == 4 && p == 0
			layout = ["row_4l_0p_6","row_4l_0p_8","row_4l_0p_3"]
		elsif l == 0 && p == 4
			layout = ["row_0l_4p_11"]
		end
		return self.send(layout.sample)
	end


	def row_3l_1p_1
		html = content_tag(:div,class:"row row_3l_1p_1") do
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



	def row_4l_0p_3
		html = content_tag(:div,class:"row row_4l_0p_3") do
			cols = []
			cols << picture_col("col50") {image_factory(@landscape.first, "h100")}
			cols << picture_col("col50 last-col") do 
				pics = []
				pics << image_factory(@landscape.second, "h60")
				2.times do |i|
					pics << image_factory(@landscape[i+2], "w50 h30",(i == 0 ? "float:left" : ""))
				end
				pics.join.html_safe
		 	end
		 	cols.join.html_safe
		end
		html.html_safe
	end



	def row_2l_2p_4
		html = content_tag(:div,class:"row row_2l_2p_4") do 
			cols = 2.times.collect{|i| picture_col("col33") {image_factory(@portrait[i], "h100")} }
			cols << picture_col("col33") do 
				2.times.collect{|i| image_factory(@landscape[i], "h50")}.join.html_safe
		 	end
		 	cols.join.html_safe
		end
		html.html_safe
	end 



	def row_1l_3p_5
		html = content_tag(:div,class:"row row_1l_3p_5") do 
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


	def row_4l_0p_6
		html = content_tag(:div,class:"row row_4l_0p_6") do
			cols = []
			cols << picture_col("col75") {image_factory(@landscape.first, "h100")}
			cols << picture_col("col25 last-col") do 
				pics = []
				pics << image_factory(@landscape.second, "h33 w100")
				2.times{|i| pics << image_factory(@landscape[i+2], "h33 w100 top50")}
				pics.join.html_safe
		 	end
		 	cols.join.html_safe
		end
		html.html_safe
	end


	def row_3l_1p_7
		html = content_tag(:div,class:"row row_3l_1p_7") do
			cols = []
			cols << picture_col("col25") {image_factory(@portrait.first, "h100")}
			cols << picture_col("col50") {image_factory(@landscape.first, "h100")}
			cols << picture_col("col25 last-col") do 
				2.times.collect{|i| image_factory(@landscape[i+1], "h50")}.join.html_safe
		 	end
		 	cols.join.html_safe
		end
		html.html_safe
	end


	def row_4l_0p_8
		html = content_tag(:div,class:"row row_4l_0p_8") do
			cols = []
			cols << picture_col("col25") do 
				pics = []
				pics << image_factory(@landscape.first, "h33 w100")
				2.times{|i| pics << image_factory(@landscape[i+1], "h33 w100 top50")}
				pics.join.html_safe
		 	end
		 	#cols << picture_col("col75","width:74.2%; margin-left:8px") do 
		 	cols << picture_col("col75") do 
	 			image_factory(@landscape.last, "h100","margin:0 0 0 10px")
	 		end
		 	cols.join.html_safe
		end
		html.html_safe
	end


	def row_2l_2p_9
		html = content_tag(:div,class:"row row_2l_2p_9") do 
			cols = []
			cols << picture_col("col33") do 
				2.times.collect{|i| image_factory(@landscape[i], "h50")}.join.html_safe
		 	end
		 	2.times{|i| cols << picture_col("col33") {image_factory(@portrait[i], "h100")} }
		 	cols.join.html_safe
		end
		html.html_safe
	end


	def row_1l_3p_10
		html = content_tag(:div,class:"row row_1l_3p_10") do 
			cols = []
			cols << picture_col("col20") do 
				pics = []
				pics << image_factory(@landscape.first, "h30","margin-top:0px;width:96%")
				pics << image_factory(@portrait.first, "h60 top50","margin-top:63px;height:55.3%")
				pics.join.html_safe
		 	end
			2.times{|i| cols << picture_col("col40 #{i>0 ? 'last-col' : ''}") { image_factory(@portrait[i+1], "h100")}}
		 	cols.join.html_safe
		end
		html.html_safe
	end


	def row_0l_4p_11
		html = content_tag(:div,class:"row row_0l_4p_11") do
			cols = 4.times.collect do |i| 
							class_name = (i==3 ? "col25 last-col" : "col25")
							picture_col(class_name) {image_factory(@portrait[i], "h100")}
						end
			cols.join.html_safe
		end
		html.html_safe
	end


	def picture_col(class_name,style="", &block)
		html = content_tag(:div,class:"col #{class_name}",style:style) do 
			inner_html = content_tag(:nil, &block)
			inner_html.html_safe
		end
		html.html_safe	
	end

	def image_factory(photo,class_name="",style="")
		return if photo.nil?
		html = content_tag(:div,class:"img-container #{class_name}", style:style, id:"img-container-#{photo.id}") do 
			inner_html = []
			inner_html << link_to(user_photo_path(photo.id,gallary_type:@gallary_type),method: :delete,remote:true,
										class:'btn destroy-photo',data:{confirm:t("messages.confirm_destroy")}) do 
				content_tag(:span,"",class:"icon16pb destroy").html_safe
			end if @location == :user_photos
			inner_html << content_tag(:div,class:"img-pic", 
										style:"background-image: url('#{photo.picture.url(@photo_size)}')",
										owner:photo.user.profile.user_name) do
				pic = []
				pic << photo_resume_counts(photo)
				pic << build_url(photo)
				pic.join.html_safe
			end
			inner_html << content_tag(:div,class:"img-info") do 
				html_info = []
				html_info << photo_details(photo)
				html_info.join.html_safe
			end if @show_details
			inner_html.join.html_safe
		end
		html.html_safe
	end

private 
	
	def photo_resume_counts(photo)
		content_tag(:ul,class:"photo-counts") do 
			html_info = []
			html_info << content_tag(:li) do 
				html_info_item = []
				html_info_item << content_tag(:span,"Visualizacoes")
				html_info_item << content_tag(:h1, photo.views_count)
				html_info_item.join.html_safe
			end
			html_info << content_tag(:li) do 
				html_info_item = []
				html_info_item << content_tag(:span,"Curtidas")
				html_info_item << content_tag(:h1, photo.likes_count,id:"photo-gallery-likes-count-#{photo.id}")
				html_info_item.join.html_safe
			end
			html_info.join.html_safe
		end.html_safe
	end

	def photo_details(photo)
		content_tag(:div) do 
			html_details = []
			html_details << avatar_tag(photo.user.profile.avatar.url(:thumb),class:'user-avatar avatar-rounded')
			html_details << content_tag(:div,class:"details-content") do 
				html_content = []
				if @location == :photos_explore
					html_content << link_to(photo.user.profile.short_name,
																	photographer_link_path(:photographer_profile,photo.user),
					 												class:"photographer-profile") #photographers name
					html_content << (render partial:'user/shared/photo/menu_popup', locals:{photo:photo} )
				elsif @location == :user_photos
					html_content << content_tag(:label,photo.title,class:"photo-title")
				end
				html_content << content_tag(:p,distance_of_time_in_words(photo.created_at, Time.now))
				html_content.join.html_safe
			end
			html_details.join.html_safe
		end.html_safe
	end

	def build_url(photo)
		html = ""
		if @location == :user_photos
		 	link_to("", user_photo_path(photo), class:'photo-picture')
		elsif @location == :photos_explore
			link_to("", user_photo_explore_show_path(photo),class:'photo-picture')
		elsif @location == :profile_cover
			link_to("", user_update_cover_photo_path(photo),class:'profile-photo-cover',
									remote:true, method: :put)
		end
	end
end

def options_grid_style
	html = []
	html << content_tag(:div, class:'grid-styles') do 
		inner_html = []
		inner_html << link_to(build_gallary_type_link("flow"), 
								class:"link-gallary-type #{@gallary_type.to_sym == :flow ? "selected" : ""}", 
								remote:true) do 
			content_tag(:span, "", class:"icon20pb icon-grid-flow")
		end 
		inner_html << link_to(build_gallary_type_link("table"), 
									class:"link-gallary-type #{@gallary_type.to_sym == :table ? "selected" : ""}", 
									remote:true) do 
			content_tag(:span, "", class:"icon20pb icon-grid-table")
		end 
		inner_html << link_to(build_gallary_type_link("list"), 
									class:"link-gallary-type #{@gallary_type.to_sym == :list ? "selected" : ""}", 
									remote:true) do 
			content_tag(:span, "", class:"icon20pb icon-grid-list")
		end 
		inner_html.join.html_safe
	end
	html.join.html_safe
end

def build_gallary_type_link(type)
	if @location == :user_photos
		user_photos_path(gallary_type:type)
	else
		user_photo_explore_path(gallary_type:type)
	end
end


