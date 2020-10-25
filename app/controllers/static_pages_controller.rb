class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      @feed_atcoder_user_ids = @user.get_fol_ids << @user.atcoder_user.id

      contest_names = History.where(atcoder_user_id: @feed_atcoder_user_ids).pluck(:contest_name)
      @contests = Contest.where(name: contest_names).order(start_epoch_second: :desc).paginate(page: params[:contests])
      # scoped preload
      # ActiveRecord::Associations::Preloader.new.preload(@contests, :histories, History.where(atcoder_user_id: feed_atcoder_user_ids))
      # @contests = Contest.where("name IN (#{contest_names})",fol_ids: @fol_ids, atcoder_user_id: @atcoder_user.id).paginate(page: params[:contests])

      # @users = User.where(id: [1,2])
      # ActiveRecord::Associations::Preloader.new.preload(@users, :relationships, Relationship.where(followed_id: 3))
      # ActiveRecord::Associations::Preloader.new.preload(@users, :relationships)

      # @users.each do |user|
      #   user.relationships.each do |rel|
      #     puts rel.id
      #   end
      # end


      # @contests.each do |contest|
      #   contest.histories.each do |his|
      #     puts his.new_rating
      #   end
      # end

      @submissions = Submission.where(atcoder_user_id: @feed_atcoder_user_ids)
                                .includes(:atcoder_user, :contest, :problem)
                                .order(epoch_second: :desc)
                                .paginate(page: params[:submissions])
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
