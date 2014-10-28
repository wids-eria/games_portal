class ApplicationController < ActionController::Base

  skip_authorization_check
  def forem_user
    current_user
  end
  helper_method :forem_user
  protect_from_forgery

  def current_user
    if session[:id].nil?
      return false
    end
    return User.find_by_id(session[:id])
  end

  def guest
    return current_user.guest
  end



  def login_required
    if !current_user
      respond_to do |format|

        format.html  {
          redirect_to '/auth/ada'
        }
        format.json {
          render :json => { 'error' => 'Access Denied' }.to_json
        }
      end
    end
  end

  def return_path
    session[:return_path] ? session[:return_path] : root_path
  end

  def set_return(path)
    session[:return_path] = path
  end
  private

  def must_consent
    unless current_user.consented?
      set_return(request.url)
      redirect_to consent_form_url
    end
  end

  def embedded_svg filename, options={}
    file = File.read(Rails.root.join('app', 'assets', 'images', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    doc.to_html.html_safe
  end
end
