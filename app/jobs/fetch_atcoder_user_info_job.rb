class FetchAtcoderUserInfoJob < ApplicationJob
  queue_as :default

  def perform(atcoder_user)
    api_client = APIClient.new
    api_client.fetch_user_history(atcoder_user)
    api_client.fetch_user_submissions(atcoder_user)
    api_client.fetch_user_accepted_count(atcoder_user)
  end
end
