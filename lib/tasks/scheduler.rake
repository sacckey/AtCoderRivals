# 本番環境用のタスク
desc "最近の提出をDBに保存するタスク"
  task recent_submissions: :environment do
    Crawler.get_recent_submissions
  end

  desc "コンテスト情報をDBに保存するタスク"
  task contests: :environment do
    # コンテスト情報が更新されたら、問題情報とコンテスト参加情報も更新する
    if Crawler.get_contests
      sleep 10
      Crawler.get_problems
      sleep 10
      Crawler.get_histories
    end
  end