def get_contests
  uri = URI.parse("https://kenkoooo.com/atcoder/resources/contests.json")
  result = call_api(uri)
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

User.create!(user_name:  "Example User",
  uid: "12345",
  provider:  "twitter",
  image_url: "https://pbs.twimg.com/profile_images/1066244463725445120/m-owVBJX_normal.jpg",
  atcoder_id: "chokudai")

# 99.times do |n|
# user_name  = Faker::Name.name
# provider = "twitter"
# uid = "#{n+1}"
# image_url = "https://pbs.twimg.com/profile_images/1066244463725445120/m-owVBJX_normal.jpg"
# atcoder_id = "chokudai"
# User.create!(user_name:  user_name,
#   uid: uid,
#   provider: provider,
#   image_url: image_url,
#   atcoder_id: atcoder_id)
# end


contests = get_contests
contests.each do |contest|
  Contest.create!(
    abbreviation: contest["id"],
    start_epoch_second: contest["start_epoch_second"],
    duration_second: contest["duration_second"],
    title: contest["title"],
    rate_change: contest["rate_change"]
  )
end