OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :ada, ENV['ADAName'], ENV['ADASecret'], :callback_path => "/auth/ada/callback", scope:"portal"
  if ENV['SITE_URL']
    OmniAuth.config.full_host = ENV['SITE_URL']
  end
end