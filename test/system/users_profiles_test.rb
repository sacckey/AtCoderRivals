require "application_system_test_case"

class UsersProfilesTest < ApplicationSystemTestCase
  include ApplicationHelper
  driven_by :selenium, using: :headless_chrome, screen_size: [1920, 1080]

  def setup
    @user = users(:example_user)
    OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
        :provider => @user.provider,
        :uid => @user.uid,
        :info =>  {:name => @user.user_name, :image => @user.image_url}
      })
  end

  test "profile display" do
    visit root_path
    click_link 'Sign up with Twitter'
    visit user_path(@user)
    assert_title full_title(@user.user_name)
    assert_selector 'h1', text: @user.user_name
    assert_selector 'section.user_info > a > img'
    assert_selector 'ul.pagination'
    @user.atcoder_user.submissions.page(1).each do |submission|
      assert_text Time.at(submission.epoch_second)
    end
  end
end
