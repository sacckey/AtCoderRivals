class User < ApplicationRecord
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :relationships, source: :followed
  belongs_to :atcoder_user

  before_save { uid.downcase! }
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { case_sensitive: false }
  validates :user_name, presence: true
  validates :image_url, presence: true
  validates :atcoder_user_id, presence: true

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    user_name = auth[:info][:name]
    image_url = auth[:info][:image]
    atcoder_id = "chokudai"

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.user_name = user_name
      user.image_url = image_url
      user.atcoder_user_id = AtcoderUser.find_or_create_atcoder_user(atcoder_id).id
    end
  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  def submission_feed
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    Submission.where("atcoder_user_id IN (#{following_ids})
                     OR atcoder_user_id = :atcoder_user_id",user_id: id, atcoder_user_id: atcoder_user_id)
  end

  private
    
end