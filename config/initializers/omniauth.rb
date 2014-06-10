Rails.application.config.middleware.use OmniAuth::Builder do
  provider :ada, ENV['ADAName'], ENV['ADASecret'], :callback_path => "/auth/ada/callback",scope:"portal"
OmniAuth.config.full_host = "http://gamesportal.gameslearningsociety.org/"
end
