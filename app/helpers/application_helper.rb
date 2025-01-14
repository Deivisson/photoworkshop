module ApplicationHelper

  def format_date(date, format = :default)
    return "" if date.nil? 
    return date if !date.is_a?(Date) && !date.is_a?(DateTime) && !date.is_a?(ActiveSupport::TimeWithZone)
    I18n.localize(date, :format => format)
  end
  
  def translate_attribute(model,attribute,colon=false)
    "#{model.human_attribute_name(attribute)}#{colon ? ':' : ''} "
  end
  alias_method :ta, :translate_attribute

  def translate_model(model,pluralize=true,colon=false)
    ret = pluralize ? model.model_name.human.pluralize : model.model_name.human
    return ret +  "#{colon ? ':' : ''} "
  end
  alias_method :tm, :translate_model

  def show_field(model_instance,attribute,content=nil,as_link=false,truncate=false)
    html = []
    html << content_tag(:p,class:'colon') do
      inner_html = []
      text = ta(model_instance.class,attribute.to_sym)
      text = text.truncate(17) if truncate
      inner_html << content_tag(:strong,text)

      content = (content.nil? ? model_instance.send(attribute) : content)
      if as_link
        inner_html << link_to(content,content,target:"_blank") unless content.nil?
      else
        inner_html << content_tag(:span,content)
      end

      inner_html.join.html_safe
    end
    html.join.html_safe
  end
  alias_method :sf, :show_field

  def attachment_extension_picture(type)
    file =  if type.match("word")
              "word.png"
            elsif type.match("pdf")
              "pdf.png"
            elsif type.match(/\Aimage\/.*\Z/)
              "image.png"
            else
              "no_extension.png"
            end
    return "user/#{file}"
  end

  def google_analytics_script
    script = <<-SCRIPT
      <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-68275906-1', 'auto');
        ga('send', 'pageview');

      </script>
    SCRIPT
    script.html_safe
  end

  def yes_no(value)
    return "Sim" if value
    return "Não" if !value
  end

  def photo_full_url(photo,size)
    URI.join(ActionController::Base.asset_host, photo.picture.url(size))
  end

  def avatar_tag(avatar_url,html_options={})
    options = {} 
    options.merge!(html_options)
    options.merge!(style:"background-image:url(#{path_to_image(avatar_url)})")
    html = content_tag(:div,"",options)
    html.html_safe
  end
end
