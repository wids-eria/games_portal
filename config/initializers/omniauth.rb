Rails.application.config.middleware.use OmniAuth::Builder do
  provider :ada, 'foo', 'bar', :callback_path => "/auth/ada/callback"
end
