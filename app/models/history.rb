class History < ApplicationRecord
  belongs_to :atcoder_user
  belongs_to :contest

  validates :is_rated, inclusion: {in: [true, false]}
  validates :place, presence: true
  validates :old_rating, presence: true
  validates :new_rating, presence: true
  validates :performance, presence: true
  validates :inner_performance, presence: true
  validates :contest_screen_name, presence: true
  validates :end_time, presence: true
  validates :atcoder_user_id, presence: true
  validates :contest_id, presence: true

  def self.create_history(atcoder_user)
    if atcoder_user.histories.empty?
      history = atcoder_user.get_history
      history_list = []
      history.each do |res|
        history_list << 
        atcoder_user.histories.build(
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
      History.import history_list
    end
  end
end
