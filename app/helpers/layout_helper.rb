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
end
