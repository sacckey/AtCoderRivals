class History < ApplicationRecord
  belongs_to :atcoder_user
  belongs_to :contest

  def self.create_history(atcoder_user)
    if atcoder_user.histories.empty?
      history = atcoder_user.get_history
      history.each do |res|
        atcoder_user.histories.create!(
          is_rated: res["IsRated"],
          place: res["Place"],
          old_rating: res["OldRating"],
          new_rating: res["NewRating"],
          performance: res["Performance"],
          inner_performance: res["InnerPerformance"],
          contest_screen_name: res["ContestScreenName"],
          end_time: res["EndTime"],
          contest_id: Contest.find_by(title: res["ContestName"]).id
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
