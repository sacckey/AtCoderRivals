api_client = APIClient.new

chokudai = AtcoderUser.create(atcoder_id: 'chokudai')

User.create!(
  user_name:  "Example User",
  uid: "12345",
  provider:  "twitter",
  image_url: "icon.png",
  atcoder_user: chokudai,
  twitter_uid: "12345"
)

api_client.get_contests
api_client.get_problems
api_client.update_rating