# ローカル用のタスク
# TODO: 必要ないのでそのうち消す
namespace :bot do
  desc "最近の提出を取得するタスク"
  task recent_submissions: :environment do
    APIClient.new.get_recent_submissions
  end

  desc "コンテストを取得するタスク"
  task contests: :environment do
    api_client = APIClient.new

    # 新しいコンテストを取得したら、問題/コンテスト参加履歴/提出/新レートも取得する
    if api_client.get_contests
      api_client.get_problems
      api_client.get_histories
      api_client.update_rating
    end
  end

  desc "ユーザー毎に提出を取得するタスク"
  task user_submissions: :environment do
    APIClient.new.get_submissions
  end
end
