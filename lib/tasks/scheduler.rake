# 本番環境用のタスク
desc "最近の提出を取得するタスク"
task recent_submissions: :environment do
  APIClient.new.fetch_recent_submissions
end

desc "コンテストを取得するタスク"
task contests: :environment do
  api_client = APIClient.new

  last_id = Contest.last.id
  api_client.fetch_contests

  next if Contest.last.id == last_id

  # 新しいコンテストを取得した場合は問題とコンテスト結果も取得し、レーティングを更新する
  api_client.fetch_problems
  Contest.where("id > ?", last_id).each do |contest|
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
  next unless Time.current.monday?

  AtcoderUser.find_each do |atcoder_user|
    atcoder_user.fetch_image_url_and_rating
    atcoder_user.save! if atcoder_user.valid?
  end
end
