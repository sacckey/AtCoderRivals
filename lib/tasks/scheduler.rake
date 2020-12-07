# 本番環境用のタスク
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

    contest = Contest.last
    api_client.fetch_contest_result(contest)
    api_client.update_rating
  end
end

desc "ユーザー毎に提出を取得するタスク"
task user_submissions: :environment do
  APIClient.new.get_submissions
end

# 廃止
# desc "AtCoderユーザーのAC数等を更新するタスク"
# task atcoder_user_info: :environment do
#   APIClient.new.update_atcoder_user_info
# end

desc "AtCoderユーザーのAC数を更新するタスク"
task accepted_count: :environment do
  APIClient.new.fetch_accepted_count
end

desc "AtCoderユーザーのACした問題のポイントの合計を更新するタスク"
task rated_point_sum: :environment do
  APIClient.new.fetch_rated_point_sum
end

desc "AtCoderユーザーのratingとimage_urlを更新するタスク"
task image_url_and_rating: :environment do
  AtcoderUser.find_each do |atcoder_user|
    atcoder_user.set_image_url_and_rating
    atcoder_user.save
  end
end