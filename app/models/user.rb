class User < ApplicationRecord
  before_save { uid.downcase! }
  validates :provider, presence: true
  validates :uid, presence: true,uniqueness: { case_sensitive: false }
  validates :user_name, presence: true
  validates :atcoder_id, presence: true


  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    user_name = auth[:info][:user_name]
    image_url = auth[:info][:image]
    atcoder_id = uid

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.user_name = user_name
      user.image_url = image_url
    end
  end
end