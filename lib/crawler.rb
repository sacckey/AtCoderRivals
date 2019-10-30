class Crawler
  def self.get_recent_submissions
    # atcoder_users = AtcoderUser.pluck(:atcoder_id)
    # uri = URI.parse(URI.encode "https://kenkoooo.com/atcoder/atcoder-api/v3/from/#{Time.now.to_i}")
    uri = URI.parse(URI.encode "https://kenkoooo.com/atcoder/atcoder-api/v3/from/1572358980")
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
    end

    Submission.import! submissions_list, on_duplicate_key_ignore: true
  end

  private

  @cache = {}

  def self.call_api(uri, use_etag: true)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    etag = @cache[uri] ? @cache[uri][:etag] : ""
    res = https.start do
      https.get(uri.request_uri, {"If-None-Match"=>etag})
    end
    if res.code == '200'
      STDERR.puts "get"
      @cache[uri] = {etag: res["Etag"]} if use_etag
      JSON.parse(res.body)
    elsif res.code == '304'
      STDERR.puts "cached"
      nil
    else

    end
  end
end