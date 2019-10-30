namespace :bot do
  desc "最近の提出をDBに保存するタスク"
  task recent_submissions: :environment do
    Crawler.get_recent_submissions
    sleep 15
    Crawler.get_recent_submissions
    sleep 15
    Crawler.get_recent_submissions
  end
end
