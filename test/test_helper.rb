ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  fixtures :all
  include ApplicationHelper

  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in_as(user)
    session[:user_id] = user.id
  end

  class ActionDispatch::IntegrationTest
    def log_in_as(user)
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
        :provider => user.provider,
        :uid => user.uid,
        :info =>  {:name => user.user_name, :image => user.image_url}
      })
      get "/auth/twitter"
      follow_redirect!
    end
  end
end