class APIClient
  def initialize
    @logger = Logger.new(STDOUT)
    @etag = REDIS.get('etag') || ""
  end

  def fetch_recent_submissions
    @logger.info("start: fetch_recent_submissions")
    uri = "https://kenkoooo.com/atcoder/atcoder-api/v3/from/#{1.hour.ago.to_i}"
    submissions = call_api(uri)
    if submissions.blank?
      @logger.info("end: fetch_recent_submissions\n")
      return
    end

    submission_list = []
    submissions.each do |submission|
      next if submission["result"] =~ /WJ|WR|\d.*/
      next if Submission.find_by(number: submission["id"])

      atcoder_user = AtcoderUser.find_by(atcoder_id: submission["user_id"])
      next if atcoder_user.nil?

      submission_list <<
        {
          atcoder_user_id: atcoder_user.id,
          number: submission["id"],
          epoch_second: submission["epoch_second"],
          problem_name: submission["problem_id"],
          contest_name: submission["contest_id"],
          language: submission["language"],
          point: submission["point"],
          result: submission["result"]
        }
    end

    Submission.import! submission_list
    @logger.info("end: fetch_recent_submissions\n")
  end

  def fetch_contests
    @logger.info("start: fetch_contests")
    uri = "https://kenkoooo.com/atcoder/resources/contests.json"
    contests = call_api(uri)
    REDIS.set('etag', @etag)

    if contests.blank?
      @logger.info("end: fetch_contests")
      return
    end

    contest_list = []
    contests.each do |contest|
      next if Contest.find_by(name: contest["id"])

      contest_list <<
        {
          name: contest["id"],
          start_epoch_second: contest["start_epoch_second"],
          duration_second: contest["duration_second"],
          title: contest["title"],
          rate_change: contest["rate_change"]
        }
    end
    Contest.import! contest_list
    @logger.info("end: fetch_contests")

    return contest_list
  end

  def fetch_problems
    @logger.info("start: fetch_problems")
    uri = "https://kenkoooo.com/atcoder/resources/problems.json"
    problems = call_api(uri)

    if problems.blank?
      @logger.info("end: fetch_problems")
      return
    end

    problem_list = []
    problems.each do |problem|
      next if Problem.find_by(name: problem["id"])

      problem_list <<
      {
        name:  problem["id"],
        title: problem["title"],
        contest_name:  problem["contest_id"]
      }
    end
    Problem.import! problem_list
    @logger.info("end: fetch_problems")
  end

  def fetch_histories
    @logger.info("start: fetch_histories")
    history_list = []
    AtcoderUser.find_each do |atcoder_user|
      uri = "https://atcoder.jp/users/#{atcoder_user.atcoder_id}/history/json"
      history = call_api(uri)

      next if history.blank?

      history.each do |res|
        next if History.find_by(atcoder_user_id: atcoder_user.id, contest_name: res["ContestScreenName"][/(.*?)\./,1])

        history_list <<
        {
          atcoder_user_id: atcoder_user.id,
          is_rated: res["IsRated"],
          place: res["Place"],
          old_rating: res["OldRating"],
          new_rating: res["NewRating"],
          performance: res["Performance"],
          inner_performance: res["InnerPerformance"],
          contest_screen_name: res["ContestScreenName"],
          end_time: res["EndTime"],
          contest_name: res["ContestScreenName"][/(.*?)\./,1]
        }
      end
    end
    History.import! history_list
    @logger.info("end: fetch_histories")
  end

  def fetch_user_history(atcoder_user)
    @logger.info("start: fetch #{atcoder_user.atcoder_id}'s history")
    history_list = []
    uri = "https://atcoder.jp/users/#{atcoder_user.atcoder_id}/history/json"
    history = call_api(uri)

    return if history.blank?

    history.each do |res|
      next if History.find_by(atcoder_user_id: atcoder_user.id, contest_name: res["ContestScreenName"][/(.*?)\./,1])

      history_list <<
      {
        atcoder_user_id: atcoder_user.id,
        is_rated: res["IsRated"],
        place: res["Place"],
        old_rating: res["OldRating"],
        new_rating: res["NewRating"],
        performance: res["Performance"],
        inner_performance: res["InnerPerformance"],
        contest_screen_name: res["ContestScreenName"],
        end_time: res["EndTime"],
        contest_name: res["ContestScreenName"][/(.*?)\./,1]
      }
    end
    History.import! history_list
    @logger.info("end: fetch #{atcoder_user.atcoder_id}'s history")
  end

  def fetch_submissions(from_epoch_second: 25.hours.ago.to_i)
    @logger.info("start: fetch_submissions")
    AtcoderUser.find_each do |atcoder_user|
      fetch_user_submissions(atcoder_user, from_epoch_second: from_epoch_second)
    end
    @logger.info("end: fetch_submissions\n")
  end

  def fetch_user_submissions(atcoder_user, from_epoch_second: Time.current.beginning_of_year.to_i)
    @logger.info("start: fetch #{atcoder_user.atcoder_id}'s submissions")
    submission_list = []
    uri = "https://kenkoooo.com/atcoder/atcoder-api/v3/user/submissions?user=#{atcoder_user.atcoder_id}&from_second=#{from_epoch_second}"
    @etag = atcoder_user.etag
    submissions = call_api(uri)
    atcoder_user.update(etag: @etag)

    if submissions.blank?
      @logger.info("end: fetch #{atcoder_user.atcoder_id}'s submissions")
      return
    end

    submissions.each do |submission|
      next if submission["result"] =~ /WJ|WR|\d.*/
      next if Submission.find_by(number: submission["id"])

      submission_list <<
      {
        atcoder_user_id: atcoder_user.id,
        number: submission["id"],
        epoch_second: submission["epoch_second"],
        problem_name: submission["problem_id"],
        contest_name: submission["contest_id"],
        language: submission["language"],
        point: submission["point"],
        result: submission["result"]
      }
    end
    Submission.import! submission_list
    @logger.info("end: get #{atcoder_user.atcoder_id}'s submissions")
  end

  def fetch_contest_result(contest)
    uri = "https://atcoder.jp/contests/#{contest.name}/results/json"
    results = call_api(uri)
    history_list = []
    results.each do |result|
      next unless atcoder_user = AtcoderUser.find_by(atcoder_id: result["UserScreenName"])
      next if History.find_by(atcoder_user_id: atcoder_user.id, contest_name: contest.name)

      history_list <<
      {
        atcoder_user_id: atcoder_user.id,
        is_rated: result["IsRated"],
        place: result["Place"],
        old_rating: result["OldRating"],
        new_rating: result["NewRating"],
        performance: result["Performance"],
        inner_performance: result["Performance"],
        contest_screen_name: result["ContestScreenName"],
        end_time: result["EndTime"],
        contest_name: contest.name
      }
    end

    History.import! history_list
  end

  def fetch_accepted_count
    AtcoderUser.find_each do |atcoder_user|
      fetch_user_accepted_count(atcoder_user)
    end
  end

  def fetch_user_accepted_count(atcoder_user)
    uri = "https://kenkoooo.com/atcoder/atcoder-api/v3/user/ac_rank?user=#{atcoder_user.atcoder_id}"
    data = call_api(uri)
    atcoder_user.update!(accepted_count: data['count']) if data.present?
  end

  def fetch_atcoder_user_page(atcoder_id)
    uri = "https://atcoder.jp/users/#{atcoder_id}"
    html = call_api(uri)
    return html
  end

  private

  def call_api(uri)
    sleep 1
    uri = URI.parse(uri)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    https.open_timeout = 5
    https.read_timeout = 10

    begin
      res = https.start do
        https.get(uri.request_uri, {"If-None-Match"=>@etag})
      end

      case res
      when Net::HTTPSuccess
        @logger.info("get: #{uri}")
        @etag = res["Etag"]
        return JSON.parse(res.body) if res.sub_type == 'json'
        return res.body
      when Net::HTTPRedirection
        @logger.info("cached: #{uri}")
      else
        @logger.error("HTTP ERROR: code=#{res.code} message=#{res.message} uri=#{uri}")
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
