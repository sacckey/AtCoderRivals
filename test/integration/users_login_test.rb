require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example_user)
    OmniAuth.config.test_mode = true
  end

  test "login with valid information followed by logout" do
    get login_path
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      :provider => @user.provider,
      :uid => @user.uid,
      :info =>  {:name => @user.user_name, :image => @user.image_url}
    })
    get "/auth/twitter"
    assert_redirected_to "/auth/twitter/callback"
    follow_redirect!
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end
