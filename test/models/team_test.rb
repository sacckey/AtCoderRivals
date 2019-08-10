require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  def setup
    @team = Team.new(name: "Example Team", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @team.valid?
  end

  test "name should be present" do
    @team.name = "     "
    assert_not @team.valid?
  end

  test "name should not be too short" do
    @team.name = "a" * 2
    assert_not @team.valid?
  end

  test "name should not be too long" do
    @team.name = "a" * 17
    assert_not @team.valid?
  end

  test "name should be unique" do
    duplicate_team = @team.dup
    duplicate_team.name = @team.name.upcase
    @team.save
    assert_not duplicate_team.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_name = "ExaMplE TeaM"
    @team.name = mixed_case_name
    @team.save
    assert_equal mixed_case_name.downcase, @team.reload.name
  end

  test "password should be present (nonblank)" do
    @team.password = @team.password_confirmation = " " * 6
    assert_not @team.valid?
  end

  test "password should have a minimum length" do
    @team.password = @team.password_confirmation = "a" * 5
    assert_not @team.valid?
  end

end
