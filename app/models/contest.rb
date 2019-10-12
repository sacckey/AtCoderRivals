class Contest < ApplicationRecord
  default_scope -> { order(start_epoch_second: :desc) }
end
