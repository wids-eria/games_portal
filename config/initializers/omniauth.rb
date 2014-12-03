OmniAuth.config.logger = Rails.logger

SETUP_PROC = lambda do |env|
  #Override the Omniauth values because env variables can't be loaded before the gem initlization
  env['omniauth.strategy'].options[:client_options][:site] = ENV['ADA_URL']
  env['omniauth.strategy'].options[:client_options][:authorize_url] = ENV['ADA_URL'] +"/auth/ada/authorize"
  env['omniauth.strategy'].options[:client_options][:access_token_url] = ENV['ADA_URL'] + "/auth/ada/access_token"
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :ada, ENV['ADAName'], ENV['ADASecret'], :setup => SETUP_PROC

  if ENV['SITE_URL']
    OmniAuth.config.full_host = ENV['SITE_URL']
  end
end

