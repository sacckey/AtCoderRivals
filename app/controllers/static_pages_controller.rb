class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      @atcoder_user = @user.atcoder_user
      @contests = Contest.all.paginate(page: params[:page])
      @history = @atcoder_user.histories
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
