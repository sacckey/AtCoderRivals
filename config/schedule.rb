set :output, 'log/crontab.log'
ENV['RAILS_ENV'] ||= 'development'
set :environment, ENV['RAILS_ENV']

every 30.minutes do
  rake "bot:recent_submissions"
end
