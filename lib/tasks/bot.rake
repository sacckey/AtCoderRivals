# ローカル用のタスク
namespace :bot do
  desc "最近の提出を取得するタスク"
  task recent_submissions: :environment do
    Crawler.get_recent_submissions
  end

  desc "コンテストを取得するタスク"
  task contests: :environment do
    # 新しいコンテストを取得したら、問題/コンテスト参加履歴/提出も取得する
    if Crawler.get_contests
      sleep 5
      Crawler.get_problems
      sleep 5
      Crawler.get_histories
      sleep 5
      Crawler.get_submissions
    end
  end

  desc "ユーザー毎に提出を取得するタスク"
  task user_submissions: :environment do
    Crawler.get_submissions
  end
end
