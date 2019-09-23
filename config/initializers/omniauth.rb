Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['APP_ID'], ENV['APP_SECRET']
end