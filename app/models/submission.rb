class Submission < ApplicationRecord
  belongs_to :problem, foreign_key: :problem_name, primary_key: :name
  belongs_to :contest, foreign_key: :contest_name, primary_key: :name
  belongs_to :atcoder_user

  validates :number, presence: true
  validates :epoch_second, presence: true
  validates :problem_name, presence: true
  validates :contest_name, presence: true
  validates :atcoder_user_id, presence: true
  validates :language, presence: true
  validates :point, presence: true
  validates :result, presence: true
end