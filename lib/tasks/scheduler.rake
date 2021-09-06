# 本番環境用のタスク
desc "最近の提出を取得するタスク"
task recent_submissions: :environment do
  APIClient.new.fetch_recent_submissions
end

desc "コンテストを取得するタスク"
task contests: :environment do
  api_client = APIClient.new

  new_contests = api_client.fetch_contests
  next if new_contests.blank?

  # 新しいコンテストを取得したら、問題/コンテスト参加履歴/提出/新レートも取得する
  api_client.fetch_problems
  new_contests.each do |new_contest|
    api_client.fetch_contest_result(contest)
  end
  AtcoderUser.update_rating
end

desc "ユーザー毎に提出を取得するタスク"
task user_submissions: :environment do
  APIClient.new.fetch_submissions
end

desc "AtCoderユーザーのAC数を更新するタスク"
task accepted_count: :environment do
  APIClient.new.fetch_accepted_count
end

desc "AtCoderユーザーのratingとimage_urlを更新するタスク"
task image_url_and_rating: :environment do
  AtcoderUser.find_each do |atcoder_user|
    atcoder_user.fetch_image_url_and_rating
    atcoder_user.save
  end
end
