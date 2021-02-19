FirebaseIdToken.configure do |config|
  config.redis = Redis.new(url: ENV.fetch('REDIS_URL'), size: 1, network_timeout: 5)
  config.project_ids = ["atcoder-rivals"]
end