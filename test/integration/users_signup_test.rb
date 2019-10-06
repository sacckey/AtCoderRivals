require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.new(provider: "twitter", uid: "12345", user_name: "example user", image_url: "https://pbs.twimg.com/profile_images/1066244463725445120/m-owVBJX_normal.jpg", atcoder_id: "example_user")
    OmniAuth.config.test_mode = true
  end

  test "valid signup information" do
    get signup_path
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      :provider => @user.provider,
      :uid => @user.uid,
      :info =>  {:name => @user.user_name, :image => @user.image_url}
    })
    assert_difference 'User.count', 1 do
      get "/auth/twitter"
      assert_redirected_to "/auth/twitter/callback"
      follow_redirect!
      assert_redirected_to user_path(User.find_by(uid: @user.uid).id)
      follow_redirect!
      assert_template 'users/show'
      assert_not flash.empty?
    end
  end

  test "invalid signup information" do
    get signup_path
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
    assert_difference 'User.count', 0 do
      get "/auth/twitter"
      assert_redirected_to "/auth/twitter/callback"
      follow_redirect!
      assert_redirected_to "/auth/failure?message=invalid_credentials&strategy=twitter"
      follow_redirect!
      assert_redirected_to login_path
      follow_redirect!
      assert_template 'sessions/new'
      assert_not flash.empty?
    end
  end
end
