set :output, 'log/crontab.log'
ENV['RAILS_ENV'] ||= 'development'
set :environment, ENV['RAILS_ENV']

every 10.minutes do
  rake "bot:recent_submissions"
end

every 1.hours, at: 05 do
  rake "bot:contests"
end

every 1.day, at: '0:45 am' do
  rake "bot:user_submissions"
end

every 1.day, at: '0:32 am' do
  rake "bot:atcoder_user_info"
end