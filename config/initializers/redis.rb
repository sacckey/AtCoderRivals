REDIS = Redis.current = Redis.new(url: ENV.fetch('REDIS_URL'))
