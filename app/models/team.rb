class Team < ApplicationRecord
  before_save { self.name = name.downcase }
  validates :name, presence: true, length: { minimum: 3, maximum: 16 },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
