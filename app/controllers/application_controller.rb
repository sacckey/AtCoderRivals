class ApplicationController < ActionController::Base
  # TODO: APIだけを対象にする
  skip_forgery_protection

  include Firebase::Auth::Authenticable
  include SessionsHelper

  private
    # before action
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to root_url
      end
    end
end