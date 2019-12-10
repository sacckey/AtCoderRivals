def get_contests
  uri = URI.parse(URI.encode "https://kenkoooo.com/atcoder/resources/contests.json")
  result = call_api(uri)
end

def get_problems
  uri = URI.parse(URI.encode "https://kenkoooo.com/atcoder/resources/problems.json")
  result = call_api(uri)
end

def create_submissions(atcoder_user)
  if atcoder_user.submissions.empty?
    submissions = atcoder_user.get_submissions
    submissions_list = []
    submissions.each do |submission|
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
    Submission.import! submissions_list
  end
end

def call_api(uri)
  sleep 1
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

contests = get_contests
contest_list = []
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
Contest.import contest_list

problems = get_problems
problem_list = []
problems.each do |problem|
  problem_list << 
  Problem.new(
    name:  problem["id"],
    title: problem["title"],
    contest_name:  problem["contest_id"]
  )
end
Problem.import problem_list

chokudai = AtcoderUser.find_or_create_atcoder_user("chokudai")
create_submissions(chokudai)

User.create!(
  user_name:  "Example User",
  uid: "12345",
  provider:  "twitter",
  image_url: "icon.png",
  atcoder_user_id: 1
)