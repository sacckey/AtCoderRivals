Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV.fetch('TWITTER_API_KEY'), ENV.fetch('TWITTER_API_SECRET_KEY')
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}