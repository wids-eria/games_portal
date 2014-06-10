Rails.application.config.middleware.use OmniAuth::Builder do
  provider :ada, ENV['ADAName'], ENV['ADASecret'], :callback_path => "http://gamesportal.gameslearningsociety.org/auth/ada/callback",scope:"portal"
end
