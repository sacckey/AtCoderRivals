class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      @feed_atcoder_user_ids = @user.get_fol_ids << @user.atcoder_user.id

      contest_names = History.where(atcoder_user_id: @feed_atcoder_user_ids).pluck(:contest_name)
      @contests = Contest.where(name: contest_names).order(start_epoch_second: :desc).page(params[:contests]).per(30)
      # scoped preload
      # TODO: Rails6.0.4がリリースされたら有効にする
      # ActiveRecord::Associations::Preloader.new.preload(@contests, :histories, History.where(atcoder_user_id: @feed_atcoder_user_ids).order(place: :asc))
      # ActiveRecord::Associations::Preloader.new.preload(@contests, [histories: :atcoder_user])

      # preloadのテスト用
      # @contests.each do |contest|
      #   contest.histories.each do |his|
      #     puts his.new_rating
      #   end
      # end

      @submissions = Submission.where(atcoder_user_id: @feed_atcoder_user_ids)
                                .includes(:atcoder_user, :contest, :problem)
                                .order(epoch_second: :desc)
                                .page(params[:submissions])
                                .per(30)
                                .without_count
    else
      render layout: false
    end
  end

  def help
    render layout: false
  end

  def about
  end

  def contact
  end
end
