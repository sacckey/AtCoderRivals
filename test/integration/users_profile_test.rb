require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:example_user)
  end

  test "profile display" do
    log_in_as(@user)
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.user_name)
    assert_select 'h1', text: @user.user_name
    assert_select 'section.user_info > a > img'
    assert_match "AC", response.body
    assert_select 'div.pagination'
    @user.atcoder_user.submissions.order(epoch_second: :desc).paginate(page: 1).each do |submission|
      assert_match Time.at(submission.epoch_second).to_s, response.body
    end

    @user.atcoder_user.histories.paginate(page: 1).each do |history|
      assert_match Time.at(history.contest.start_epoch_second).to_s, response.body
    end

  end
end
