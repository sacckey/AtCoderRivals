class API::V1::AtcoderUsersController < API::V1::BaseController
  before_action :set_atcoder_user

  def show
    @is_following = current_user.following?(@atcoder_user)

    render 'api/v1/atcoder_users/atcoder_user.json.jb'
  end


  def submissions
    @submissions = Submission.where(atcoder_user_id: @atcoder_user.id)
                                .includes(:contest, :problem, :atcoder_user)
                                .order(epoch_second: :desc)
                                .page(params[:page])
                                .per(30)
                                .without_count

    render 'api/v1/atcoder_users/submissions.json.jb'
  end

  def contests
    @histories = History.where(atcoder_user_id: @atcoder_user.id)
                        .includes(:contest)
                        .order(end_time: :desc)
                        .page(params[:page])
                        .per(30)
                        .without_count

    render 'api/v1/atcoder_users/contests.json.jb'
  end

  def follow
    current_user.follow(@atcoder_user)
    render 'api/v1/success.json.jb'
  end

  def unfollow
    current_user.unfollow(@atcoder_user)
    render 'api/v1/success.json.jb'
  end

  private
  def set_atcoder_user
    @atcoder_user = AtcoderUser.find_or_create_by(atcoder_id: params[:atcoder_id])
    error!(status: 404, message: 'AtCoder IDが存在しません') if @atcoder_user.invalid?
  end
end
