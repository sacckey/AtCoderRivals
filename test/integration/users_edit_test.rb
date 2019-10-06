require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example_user)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { atcoder_id: " "}}
    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    atcoder_id = "chokudai"
    patch user_path(@user), params: { user: { atcoder_id: atcoder_id}}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal atcoder_id,  @user.atcoder_id
  end
end