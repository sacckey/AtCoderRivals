require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example_user)
    @atcoder_user = @user.atcoder_user
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { atcoder_user: { atcoder_id: " "}}
    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    atcoder_id = "tourist"
    patch user_path(@user), params: { atcoder_user: { atcoder_id: atcoder_id} }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal atcoder_id,  @user.atcoder_user.atcoder_id
  end
end