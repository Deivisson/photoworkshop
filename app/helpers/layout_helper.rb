# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper

  def title(title, options={})
    @show_title = options[:show_title] || true
    
    content_for(:title) do 
    	content_tag :h1, h(title.to_s),class:"#{options[:class]}"
  	end
    #content_for(:sub_title) { (page_sub_title.to_s).gsub("|","<br>").to_s.html_safe}
    #@show_sub_title = show_sub_title
  end

  def show_title?
    @show_title
  end

  def photographer_link_path(target,photographer)
    case target
      when :photos_count
        @namespace == :user ? user_photographer_photos_path(photographer) : public_photographer_photos_path(photographer)
      when :following_count
        @namespace == :user ? user_photographer_following_path(photographer) : public_photographer_following_path(photographer)
      when :followers_count
        @namespace == :user ? user_photographer_followers_path(photographer) : public_photographer_followers_path(photographer)
      when :owner_workshops_count
        @namespace == :user ? user_photographer_workshops_path(photographer) : public_photographer_workshops_path(photographer)
      when :about
        @namespace == :user ? user_photographer_about_path(photographer) : public_photographer_about_path(photographer)
      when :photographer_profile
        puts "hear"
        @namespace == :user ? user_photographer_path(photographer) : photographer_profile_path(photographer.profile.user_name)
    end
  end
end
