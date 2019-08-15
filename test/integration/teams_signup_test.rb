require 'test_helper'

class TeamsSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'Team.count' do
      post teams_path, params: { team: { name:  "",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'teams/new'
  end
end
