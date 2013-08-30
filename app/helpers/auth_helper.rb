module AuthHelper
  def logged_in
    return session[:token] unless session[:token].nil?
  end

  def authtoken
    return session[:token]
  end
end