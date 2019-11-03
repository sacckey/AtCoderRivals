module Crawler extend self
  # @logger = Logger.new(STDOUT)
  @logger = Logger.new('log/crontab.log')

  def get_recent_submissions
    @logger.info("start: get_recent_submissions")
    # atcoder_users = AtcoderUser.pluck(:atcoder_id)
    uri = URI.parse(URI.encode "https://kenkoooo.com/atcoder/atcoder-api/v3/from/#{Time.now.to_i-3600}")
    # uri = URI.parse(URI.encode "https://kenkoooo.com/atcoder/atcoder-api/v3/from/1572358980")
    submissions = call_api(uri, use_etag: false)
    
    submissions_list = []
    if submissions
      submissions.each do |submission|
        if atcoder_user = AtcoderUser.find_by(atcoder_id: submission["user_id"])
          submissions_list << 
            atcoder_user.submissions.build(
              number: submission["id"],
              epoch_second: submission["epoch_second"],
              problem_name: submission["problem_id"],
              contest_name: submission["contest_id"],
              language: submission["language"],
              point: submission["point"],
              result: submission["result"]
            )
        end
      end
      Submission.import! submissions_list, on_duplicate_key_ignore: true
    end
    @logger.info("end: get_recent_submissions\n")
  end

  def get_contests
    @logger.info("start: get_contests")
    uri = URI.parse(URI.encode "https://kenkoooo.com/atcoder/resources/contests.json")
    contests = call_api(uri)

    contest_list = []
    if contests
      contests.each do |contest|
        contest_list << 
        Contest.new(
          name: contest["id"],
          start_epoch_second: contest["start_epoch_second"],
          duration_second: contest["duration_second"],
          title: contest["title"],
          rate_change: contest["rate_change"]
        )
      end
      Contest.import! contest_list, on_duplicate_key_ignore: true
      @logger.info("end: get_contests")
    else
      @logger.info("end: get_contests\n")
      nil
    end
  end

  def get_problems
    @logger.info("start: get_problems")
    uri = URI.parse(URI.encode "https://kenkoooo.com/atcoder/resources/problems.json")
    problems = call_api(uri, use_etag: false)
    
    problem_list = []
    if problems
      problems.each do |problem|
        problem_list << 
        Problem.new(
          name:  problem["id"],
          title: problem["title"],
          contest_name:  problem["contest_id"]
        )
      end
      Problem.import! problem_list, on_duplicate_key_ignore: true
    end
    @logger.info("end: get_problems")
  end

  def get_histories
    @logger.info("start: get_histories")
    history_list = []
    AtcoderUser.find_each do |atcoder_user|
      uri = URI.parse(URI.encode "https://atcoder.jp/users/#{atcoder_user.atcoder_id}/history/json")
      history = call_api(uri, use_etag: false)
      
      if history
        history.each do |res|
          history_list << 
          atcoder_user.histories.build(
            is_rated: res["IsRated"],
            place: res["Place"],
            old_rating: res["OldRating"],
            new_rating: res["NewRating"],
            performance: res["Performance"],
            inner_performance: res["InnerPerformance"],
            contest_screen_name: res["ContestScreenName"],
            end_time: res["EndTime"],
            contest_name: res["ContestScreenName"][/(.*?)\./,1]
          )
        end
      end
      sleep 10
    end
    History.import! history_list, on_duplicate_key_ignore: true
    @logger.info("end: get_histories\n")
  end

  private

  @cache = {}

  def call_api(uri, use_etag: true)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    https.open_timeout = 5
    https.read_timeout = 10

    # etag = @cache[uri] ? @cache[uri][:etag] : ""
    etag = File.read('lib/.cache')

    begin
      res = https.start do
        https.get(uri.request_uri, {"If-None-Match"=>etag})
      end

      case res
      when Net::HTTPSuccess
        @logger.info("get: #{uri}")
        File.write('lib/.cache', res["Etag"]) if use_etag
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