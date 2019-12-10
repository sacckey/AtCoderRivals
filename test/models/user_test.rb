require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @atcoder_user = atcoder_users(:chokudai)
    @user = User.new(provider: "twitter", uid: "12345", user_name: "example user", image_url: "https://pbs.twimg.com/profile_images/1066244463725445120/m-owVBJX_normal.jpg", atcoder_user_id: @atcoder_user.id)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "provider should be present" do
    @user.provider = "     "
    assert_not @user.valid?
  end

  test "uid should be present" do
    @user.uid = "     "
    assert_not @user.valid?
  end

  test "user_name should be present" do
    @user.user_name = "     "
    assert_not @user.valid?
  end

  test "atcoder_user_id should be present" do
    @user.atcoder_user_id = nil
    assert_not @user.valid?
  end

  test "uid should be unique" do
    duplicate_user = @user.dup
    duplicate_user.uid = @user.uid.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
end