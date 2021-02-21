class User < ApplicationRecord
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :relationships, source: :followed
  belongs_to :atcoder_user

  # TODO: 設定する
  # before_save { uid.downcase! }
  validates :provider, presence: true
  validates :uid, presence: true
  validates :user_name, presence: true
  validates :image_url, presence: true
  validates :atcoder_user_id, presence: true

  attr_accessor :first_login

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    user_name = auth[:info][:name]
    image_url = auth[:info][:image]
    first_login = false

    user = self.find_or_initialize_by(provider: provider, uid: uid) {first_login = true}
    atcoder_user = user.atcoder_user || AtcoderUser.find_by(atcoder_id: 'chokudai')
    user.update!(
      user_name: user_name,
      image_url: image_url,
      atcoder_user: atcoder_user,
      first_login: first_login,
      twitter_uid: uid
    )

    return user
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

  def get_fol_ids
    Relationship.where(follower_id: id).pluck(:followed_id)
  end

  def following_count
    Relationship.where(follower_id: id).count
  end

  private

end