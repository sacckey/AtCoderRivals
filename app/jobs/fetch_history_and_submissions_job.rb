class FetchHistoryAndSubmissionsJob < ApplicationJob
  queue_as :default

  def perform(atcoder_user)
    api_client = APIClient.new
    api_client.get_user_history(atcoder_user)
    api_client.get_user_submissions(atcoder_user)
  end
end
