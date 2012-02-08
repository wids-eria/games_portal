ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  #include ActionView::Helpers::RawOutputHelper
  %(<div class="field_with_errors">#{html_tag}<div class="error_box"></div></div>).html_safe
end
