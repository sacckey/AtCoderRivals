class AtcoderUser < ApplicationRecord
  has_many :histories, dependent: :destroy
  has_many :contests, through: :histories
  has_many :submissions, dependent: :destroy

  validates :atcoder_id, presence: { message: "ID can't be blank" }
  validates :accepted_count, presence: true
  validates :accepted_count_rank, presence: true
  validates :rated_point_sum, presence: true
  validates :rated_point_sum_rank, presence: true
  validates :image_url, presence: true  
  validate  :atcoder_id_exist

  def self.find_or_create_atcoder_user(atcoder_id)
    atuser = self.find_or_create_by(atcoder_id: atcoder_id) do |atcoder_user|
      if user_info = atcoder_user.get_user_info
        atcoder_user.accepted_count = user_info["accepted_count"]
        atcoder_user.accepted_count_rank = user_info["accepted_count_rank"]
        atcoder_user.rated_point_sum = user_info["rated_point_sum"]
        atcoder_user.rated_point_sum_rank = user_info["rated_point_sum_rank"]
        atcoder_user.image_url = atcoder_user.get_image_url
      end
    end
    if atuser.valid?
      History.create_history(atuser) 
      Submission.create_submissions(atuser) 
    end
    return atuser
  end

  def get_history
    uri = URI.parse(URI.encode "https://atcoder.jp/users/#{atcoder_id}/history/json")
    result = call_api(uri)
  end

  def get_submissions
    uri = URI.parse(URI.encode "https://kenkoooo.com/atcoder/atcoder-api/results?user=#{atcoder_id}")
    results = call_api(uri)
  end

  def get_results(contest)
    uri = URI.parse(URI.encode "https://atcoder.jp/contests/#{contest.abbreviation}/results/json")
    results = call_api(uri)
  end

  def get_user_info
    uri = URI.parse(URI.encode "https://kenkoooo.com/atcoder/atcoder-api/v2/user_info?user=#{atcoder_id}")
    result = call_api(uri)
  end

  def get_image_url
    uri = "https://atcoder.jp/users/#{atcoder_id}"
    charset = nil
    html = open(uri) do |h|
      charset = h.charset
      h.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)
    doc.at_css('.avatar').attribute('src').value
  end

  private
  # def history_exist
  #   if errors.empty?
  #     unless History.exists?(atcoder_id: self.atcoder_id)
  #       create_history
  #     end
  #   end
  # end

  def atcoder_id_exist
    if get_user_info.nil?
      errors.add(:atcoder_id, "ID does not exist.")
    # else
    #   History.create_history(atcoder_user)
    end
  end

  # def history_exist
  #   if histories.empty? && errors.empty?
  #     History.create_history(self)

  #     errors.add(:atcoder_id, "ID does not exist.") if histories.empty?
  #   end
  # end

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