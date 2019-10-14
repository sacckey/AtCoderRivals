class Contest < ApplicationRecord
  has_many :histories, dependent: :destroy
  has_many :atcoder_users, through: :histories

  validates :abbreviation, presence: true
  validates :start_epoch_second, presence: true
  validates :duration_second, presence: true
  validates :title, presence: true
  validates :rate_change, presence: true

  default_scope -> { order(start_epoch_second: :desc) }
end
