class User < ApplicationRecord
  before_save { uid.downcase! }
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { case_sensitive: false }
  validates :user_name, presence: true
  validates :atcoder_id, presence: { message: "ID can't be blank" }

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    user_name = auth[:info][:name]
    image_url = auth[:info][:image]
    atcoder_id = user_name

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.user_name = user_name
      user.image_url = image_url
      user.atcoder_id ||= atcoder_id
    end
  end
end