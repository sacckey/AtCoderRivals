require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(provider: "twitter", uid: "example", user_name: "example user", image_url: "example.com", atcoder_id: "example_user")
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

  test "atcoder_id should be present" do
    @user.atcoder_id = "     "
    assert_not @user.valid?
  end

  test "uid should be unique" do
    duplicate_user = @user.dup
    duplicate_user.uid = @user.uid.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "uid should be saved as lower-case" do
    mixed_case_uid = "ExAMPle"
    @user.uid = mixed_case_uid
    @user.save
    assert_equal mixed_case_uid.downcase, @user.reload.uid
  end
end