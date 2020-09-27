require 'test_helper'

class FetchHistoryAndSubmissionsJobTest < ActiveJob::TestCase
  def setup
    @atcoder_user = atcoder_users(:chokudai)
  end

  test "enqueue FetchHistoryAndSubmissionsJob" do
    assert_enqueued_with(job: FetchHistoryAndSubmissionsJob) do
      FetchHistoryAndSubmissionsJob.perform_later(@atcoder_user)
    end
  end
end
