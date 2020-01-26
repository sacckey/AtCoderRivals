class AtcoderUsersController < ApplicationController
  before_action :logged_in_user, only: [:search]

  def search
    if atcoder_id = params[:search]
      @atcoder_user = AtcoderUser.find_or_create_atcoder_user(atcoder_id)
    else
      @atcoder_user = AtcoderUser.new
    end
  end

  def ranking
    @user = current_user
    @atcoder_users = @user.atcoder_users
  end
end
