require 'test_helper'

class AtcoderUserTest < ActiveSupport::TestCase
  def setup
    @atcoder_user = AtcoderUser.new(atcoder_id: 'Petr', accepted_count: 10,
      accepted_count_rank: 3, rated_point_sum: 1000.0, rated_point_sum_rank: 3,
      image_url: 'https://img.atcoder.jp/icons/6a4376b4c8a89762d6153dc31b711a36.jpg',
      rating: 1000, etag: '')
  end

  test "associated microposts should be destroyed" do
    @atcoder_user.save
    @atcoder_user.submissions.create!(epoch_second: 1575190800, language: "Java", point: 1000.0, result: "AC", contest_name: "abc100", problem_name: "abc100_a", number: 3)
    assert_difference 'Submission.count', -1 do
      @atcoder_user.destroy
    end
  end
end
