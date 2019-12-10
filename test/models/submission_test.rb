require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  def setup
    @atcoder_user = atcoder_users(:chokudai)
    @submission = @atcoder_user.submissions.build(epoch_second: 1575190800, language: "C#", point: 1000.0, result: "AC", contest_name: "abc100", problem_name: "abc100_a", number: 1)
  end

  # validation
  test "should be valid" do
    assert @submission.valid?
  end

  test "user id should be present" do
    @submission.atcoder_user_id = nil
    assert_not @submission.valid?
  end

  test "epoch_second should be present" do
    @submission.epoch_second = nil
    assert_not @submission.valid?
  end

  test "language should be present" do
    @submission.language = "     "
    assert_not @submission.valid?
  end

  test "point should be present" do
    @submission.point = nil
    assert_not @submission.valid?
  end

  test "result should be present" do
    @submission.result = "     "
    assert_not @submission.valid?
  end

  test "contest_name should be present" do
    @submission.contest_name = "abc000"
    assert_not @submission.valid?
  end

  test "problem_name should be present" do
    @submission.problem_name = "abc000_a"
    assert_not @submission.valid?
  end

  test "number should be present" do
    @submission.number = nil
    assert_not @submission.valid?
  end

  # order
  test "order should be most recent first" do
    assert_equal submissions(:most_recent), Submission.first
  end
end
