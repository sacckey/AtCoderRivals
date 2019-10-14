class Contest < ApplicationRecord
  has_many :histories, dependent: :destroy

  default_scope -> { order(start_epoch_second: :desc) }
end
