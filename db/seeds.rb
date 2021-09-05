api_client = APIClient.new

chokudai = AtcoderUser.create(atcoder_id: 'chokudai')

User.create!(
  user_name:  "Example User",
  uid: "xPDBstKIAANa0mQSAhexu7NQDN92",
  provider:  "anonymous",
  image_url: "/icon.png",
  atcoder_user: chokudai,
  twitter_uid: "12345"
)

api_client.fetch_contests
api_client.fetch_problems
AtcoderUser.update_rating
