require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example_user)
    @other_user = users(:other_user)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  # ログインしていないユーザーに対するテスト
  test "should redirect show when not logged in" do
    get users_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { atcoder_id: @user.atcoder_id} }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@other_user)
    end
    assert_redirected_to login_url
  end

  # 不正なユーザーに対するテスト
  test "should redirect show when logged in as wrong user" do
    log_in_as(@other_user)
    get users_path(@user)
    assert_redirected_to root_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { atcoder_id: @user.atcoder_id} }
    assert_redirected_to root_url
  end

  # 管理者ユーザーに対するテスト
  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: { user: { admin: true } }
    assert_not @other_user.admin?
  end

  test "should redirect index when logged in as a non-admin" do
    log_in_as(@other_user)
    get users_path
    assert_redirected_to root_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end
end
