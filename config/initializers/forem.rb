Forem.user_class = "User"
Forem.per_page = 12

Rails.application.config.to_prepare do
  Forem.layout = "application"
  Forem.moderate_first_post = false
end

