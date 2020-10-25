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
end
