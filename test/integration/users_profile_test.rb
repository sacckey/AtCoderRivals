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
    assert_match "WA", response.body
    # assert_select 'div.pagination'
    # @user.atcoder_user.submissions.paginate(page: 1).each do |submission|
    # # puts submission.result
    #   assert_match submission.language, response.body
    # end
  end
end
