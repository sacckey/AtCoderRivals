api_client = APIClient.new

chokudai = AtcoderUser.new(atcoder_id: 'chokudai')
chokudai.set_info

api_client.get_user_submissions(chokudai)
api_client.get_user_history(chokudai)

User.create!(
  user_name:  "Example User",
  uid: "12345",
  provider:  "twitter",
  image_url: "icon.png",
  atcoder_user_id: 1
)

api_client.get_contests
api_client.get_problems
api_client.update_rating