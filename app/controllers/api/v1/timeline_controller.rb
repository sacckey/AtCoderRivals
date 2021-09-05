class API::V1::TimelineController < API::V1::BaseController
  def submissions
    @user = current_user
    @atcoder_user = @user.atcoder_user

    @submissions = Submission.where(atcoder_user_id: Relationship.where(follower_id: @user.id).select(:followed_id))
                              .or(Submission.where(atcoder_user_id: @atcoder_user.id))
                              .includes(:atcoder_user, :contest, :problem)
                              .where.not(contests: {id: nil})
                              .where.not(problems: {id: nil})
                              .order(epoch_second: :desc)
                              .page(params[:page])
                              .per(30)
                              .without_count

    render 'api/v1/timeline/submissions.json.jb'
  end

  def contests
    @user = current_user
    @atcoder_user = @user.atcoder_user
    @feed_atcoder_user_ids = @user.get_fol_ids << @atcoder_user.id

    @contests = Contest.where(name: History.distinct.where(atcoder_user_id: @feed_atcoder_user_ids).select(:contest_name))
                        .order(start_epoch_second: :desc).page(params[:page]).per(30).without_count

    render 'api/v1/timeline/contests.json.jb'
  end
end
