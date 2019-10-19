class Problem < ApplicationRecord
  belongs_to :contest

  validates :problem_name, presence: true
  validates :problem_title, presence: true
  validates :contest_id, presence: true

  
end
