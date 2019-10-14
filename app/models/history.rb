class History < ApplicationRecord
  def self.create_history(atcoder_user)
    unless History.exists?(atcoder_id: atcoder_user.atcoder_id)
      history = atcoder_user.get_history
      history.each do |res|
        History.create!(
          atcoder_id: atcoder_user.atcoder_id,
          is_rated: res["IsRated"],
          place: res["Place"],
          old_rating: res["OldRating"],
          new_rating: res["NewRating"],
          performance: res["Performance"],
          inner_performance: res["InnerPerformance"],
          contest_screen_name: res["ContestScreenName"],
          contest_name: res["ContestName"],
          end_time: res["EndTime"]
        )
      end
    end
  end

  #   self.find_or_create_by(provider: provider, uid: uid) do |user|
  #     user.user_name = user_name
  #     user.image_url = image_url
  #     user.atcoder_id ||= atcoder_id
  #   end
  # end
end
