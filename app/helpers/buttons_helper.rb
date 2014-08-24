module ButtonsHelper
  def submit_button(f, options={})
    f.action :submit,
             :label => options[:label] || t('buttons.confirm'),
             :button_html => { :class => options[:class] || "submit-button",
                               :disable_with => t('buttons.wait_label') }
  end

end