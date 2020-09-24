require 'test_helper'

class AtcoderUserTest < ActiveSupport::TestCase
  def setup
    @atcoder_user = AtcoderUser.create(atcoder_id: 'Petr')
  end

  test "associated microposts should be destroyed" do
    submission_count = @atcoder_user.submissions.count
    assert_difference 'Submission.count', -submission_count do
      @atcoder_user.destroy
    end
  end
end
