class Problem < ApplicationRecord
  belongs_to :contest, foreign_key: :contest_name, primary_key: :name

  validates :name, presence: true
  validates :title, presence: true
  validates :contest_name, presence: true

  def self.get_points
    hash = Problem.group(:point).count
    point_sum = 0
    points ={"sum" => 0}
    hash.keys.each do |key|
      if key
        v = hash[key]
        points[key.to_i] = v
        point_sum+=key.to_i*v
      end
    end
    points["sum"] = point_sum
    return points
  end

  
end
