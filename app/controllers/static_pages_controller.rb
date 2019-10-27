class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      @atcoder_user = @user.atcoder_user
      @fol_ids = @user.fol_ids

      # @contests = History.where("atcoder_user_id IN (:fol_ids) OR atcoder_user_id = :atcoder_user_id",
      #   fol_ids: @fol_ids, user_id: @user.id, atcoder_user_id: @atcoder_user.id).map(&:contest)

      contest_names = "SELECT contest_name FROM histories WHERE atcoder_user_id in (:fol_ids) OR atcoder_user_id = :atcoder_user_id"
      @contests = Contest.where("name IN (#{contest_names})",fol_ids: @fol_ids, atcoder_user_id: @atcoder_user.id).paginate(page: params[:contests])

      # @contests_size = @contests.size      
      # @contests = @contests.paginate(page: params[:contests])

      # @history = @atcoder_user.histories
      @submissions = @user.submission_feed(@fol_ids).paginate(page: params[:submissions])
      # @submissions_size = @submissions.size
      # @submissions = @submissions.paginate(page: params[:submissions])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
