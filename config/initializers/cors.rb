Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    if Rails.env.production?
      origins 'atcoder-rivals.web.app', 'atcoder-rivals.firebaseapp.com'
    else
      origins 'localhost:3001'
    end

    resource '*', headers: :any, methods: [:get, :post, :patch, :put]
  end
end