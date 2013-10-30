Rails.application.config.middleware.use OmniAuth::Builder do
  provider :ada, ENV['ADAName'], ENV['ADASecret'], :callback_path => "/auth/ada/callback"
end
