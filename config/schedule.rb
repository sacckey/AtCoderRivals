set :output, 'log/crontab.log'
ENV['RAILS_ENV'] ||= 'development'
set :environment, ENV['RAILS_ENV']

every 10.minutes do
  rake "bot:recent_submissions"
end

every 1.hours do
  rake "bot:contests"
end