class AtcoderUser < ApplicationRecord
  validates :atcoder_id, presence: { message: "ID can't be blank" }
  validates :accepted_count, presence: true
  validates :accepted_count_rank, presence: true
  validates :rated_point_sum, presence: true
  validates :rated_point_sum_rank, presence: true
  validate  :atcoder_id_exist

  def self.find_or_create_atcoder_user(atcoder_id)
    self.find_or_create_by(atcoder_id: atcoder_id) do |atcoder_user|
      if user_info = atcoder_user.get_user_info
        atcoder_user.accepted_count = user_info["accepted_count"]
        atcoder_user.accepted_count_rank = user_info["accepted_count_rank"]
        atcoder_user.rated_point_sum = user_info["rated_point_sum"]
        atcoder_user.rated_point_sum_rank = user_info["rated_point_sum_rank"]

        # unless History.exists?(atcoder_id: atcoder_id)
        #   create_history
        # end
      end
    end
  end

  def get_history
    uri = URI.parse(URI.encode "https://atcoder.jp/users/#{self.atcoder_id}/history/json")
    result = call_api(uri)
  end

  def get_results(contest)
    uri = URI.parse(URI.encode "https://atcoder.jp/contests/#{contest.abbreviation}/results/json")
    results = call_api(uri)
  end

  def get_user_info
    uri = URI.parse(URI.encode "https://kenkoooo.com/atcoder/atcoder-api/v2/user_info?user=#{self.atcoder_id}")
    result = call_api(uri)
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