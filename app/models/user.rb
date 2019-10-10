class User < ApplicationRecord
  before_save { uid.downcase! }
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { case_sensitive: false }
  validates :user_name, presence: true
  validates :atcoder_id, presence: { message: "ID can't be blank" }
  validate :atcoder_id_exist

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    user_name = auth[:info][:name]
    image_url = auth[:info][:image]
    atcoder_id = "chokudai"

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.user_name = user_name
      user.image_url = image_url
      user.atcoder_id ||= atcoder_id
    end
  end


  private

    def atcoder_id_exist
      result = get_accepted_count(self)
      errors.add(:atcoder_id, "ID does not exist.") if result.nil?
    end

    def get_accepted_count(user)
      uri = URI.parse("https://kenkoooo.com/atcoder/atcoder-api/v2/user_info?user=#{user.atcoder_id}")
      result = call_api(uri)
      if !result.nil?
        ac_count=result["accepted_count"]
      end
    end

    def call_api(uri)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      res = https.start do
        https.get(uri.request_uri)
      end
      if res.code == '200'
        result = JSON.parse(res.body)
      else
        # puts "#{res.code} #{res.message}"
        # puts "No such user_id"
        # puts "test"
        # exit 1
      end
    end
end