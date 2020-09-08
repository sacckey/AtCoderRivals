class Contest < ApplicationRecord
  has_many :histories, foreign_key: :contest_name, primary_key: :name, dependent: :destroy
  has_many :atcoder_users, through: :histories
  has_many :submissions, foreign_key: :contest_name, primary_key: :name, dependent: :destroy
  has_many :problems, foreign_key: :contest_name, primary_key: :name, dependent: :destroy  

  validates :name, presence: true
  validates :start_epoch_second, presence: true
  validates :duration_second, presence: true
  validates :title, presence: true
  validates :rate_change, presence: true

  # TODO: 消す
  default_scope -> { order(start_epoch_second: :desc) }
end
