class Problem < ApplicationRecord
  belongs_to :contest, foreign_key: :contest_name, primary_key: :name

  validates :name, presence: true
  validates :title, presence: true
  validates :contest_name, presence: true

  
end
