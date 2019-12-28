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
  validates :rating, presence: true
  validate  :atcoder_id_exist

 

  def self.find_or_create_atcoder_user(atcoder_id)

    # 入力されたidに';'か' 'が入っていた場合は、それよりも前の英数字列をidにして検索する
    if m = /(\w*)[; ]/.match(atcoder_id)
      atcoder_id = m[1]
    end

    self.find_or_create_by(atcoder_id: atcoder_id) do |atcoder_user|
      if user_info = atcoder_user.get_user_info
        atcoder_user.accepted_count = user_info["accepted_count"]
        atcoder_user.accepted_count_rank = user_info["accepted_count_rank"]
        atcoder_user.rated_point_sum = user_info["rated_point_sum"]
        atcoder_user.rated_point_sum_rank = user_info["rated_point_sum_rank"]
        atcoder_user.set_image_url_and_rating
      end
    end
  end

  def get_user_info
    uri = URI.parse(URI.encode "https://kenkoooo.com/atcoder/atcoder-api/v2/user_info?user=#{atcoder_id}")
    result = call_api(uri)
  end

  def set_image_url_and_rating
    uri = "https://atcoder.jp/users/#{atcoder_id}"
    charset = nil
    html = open(uri) do |h|
      charset = h.charset
      h.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)
    self.image_url = doc.at_css('.avatar').attribute('src').value
    self.rating = doc.css('#main-container > div.row > div.col-sm-9 > table.dl-table > tr:nth-child(2) > td > span').children.text.to_i
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
    uri = URI.parse(URI.encode "https://atcoder.jp/contests/#{contest.name}/results/json")
    results = call_api(uri)
  end

  private

    def atcoder_id_exist
      if get_user_info.nil?
        errors.add(:atcoder_id, "ID does not exist.")
      end
    end

    def call_api(uri)
      sleep 1
      @logger = Logger.new(STDOUT)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      https.open_timeout = 5
      https.read_timeout = 10
  
      begin
        res = https.start do
          https.get(uri.request_uri)
        end
  
        case res
        when Net::HTTPSuccess
          @logger.info("get: #{uri}")
          return JSON.parse(res.body)
        when Net::HTTPRedirection
          @logger.info("cached: #{uri}")
        else
          @logger.error("HTTP ERROR: code=#{res.code} message=#{res.message}")
        end
  
      rescue IOError => e
        @logger.error(e.message)
      rescue TimeoutError => e
        @logger.error(e.message)
      rescue JSON::ParserError => e
        @logger.error(e.message)
      rescue => e
        @logger.error(e.message)
      end
      return nil
    end
end