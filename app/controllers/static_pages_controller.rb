class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      @atcoder_user = @user.atcoder_user
      @contests = Contest.paginate(page: params[:contests])
      # @history = @atcoder_user.histories
      @submissions = @user.submission_feed.paginate(page: params[:submissions])
      # sizeとっておく？
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
