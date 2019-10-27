class History < ApplicationRecord
  belongs_to :atcoder_user
  belongs_to :contest, foreign_key: :contest_name, primary_key: :name

  validates :is_rated, inclusion: {in: [true, false]}
  validates :place, presence: true
  validates :old_rating, presence: true
  validates :new_rating, presence: true
  validates :performance, presence: true
  validates :inner_performance, presence: true
  validates :contest_screen_name, presence: true
  validates :end_time, presence: true
  validates :atcoder_user_id, presence: true
  validates :contest_name, presence: true

  default_scope -> { order(:place) }

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
          contest_name: res["ContestScreenName"][/(.*?)\./,1]
        )
      end
      History.import! history_list
    end
  end
end
