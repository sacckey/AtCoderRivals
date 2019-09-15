require 'test_helper'

class TeamsLoginTest < ActionDispatch::IntegrationTest
  def setup
    @team = teams(:test)
  end

  test "login with invalid information" do
    get login_path
    post login_path, params: { session: { name: @team.name, password: 'password' } }
    assert_redirected_to @team
    follow_redirect!
    assert_template 'teams/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", team_path(@team)
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { name:    @team.name,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @team
    follow_redirect!
    assert_template 'teams/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", team_path(@team)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", team_path(@team), count: 0
  end
end
