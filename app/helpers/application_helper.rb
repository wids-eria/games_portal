module ApplicationHelper
  def devise_error_messagez!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
      <h4>#{sentence}</h4>
      <ul class="error_list">#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end
