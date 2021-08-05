class API::V1::UsersController < API::V1::BaseController
  # TODO: 設定する
  # before_action :logged_in_user
  before_action :correct_user, only: [:show, :edit, :update, :following, :atcoder_user]
  # before_action :admin_user, only: [:index,:destroy]
  # skip_before_action :authenticate_user, only: [:show, :submissions]

  # TODO: atcoder_users_controllerに移譲する
  # def show
  #   @user = User.find(params[:id])
  #   @atcoder_user = @user.atcoder_user

  #   @histories = History.where(atcoder_user_id: @atcoder_user.id)
  #                       .includes(:contest)
  #                       .order(end_time: :desc)
  #                       .page(params[:contests])
  #                       .per(30)
  #                       .without_count

  #   @submissions = Submission.where(atcoder_user_id: @atcoder_user.id)
  #                               .includes(:contest, :problem, :atcoder_user)
  #                               .order(epoch_second: :desc)
  #                               .page(params[:submissions])
  #                               .per(30)
  #                               .without_count

  #   render 'api/v1/users/show.json.jb'
  # end

  # TODO: atcoder_users_controllerに移譲する
  # def feeds
  #   @user = User.find(params[:id])
  #   @atcoder_user = @user.atcoder_user

  #   # TODO: feeds部分を消す
  #   @histories = History.where(atcoder_user_id: @atcoder_user.id)
  #                       .includes(:contest)
  #                       .order(end_time: :desc)
  #                       .page(params[:contests])
  #                       .per(30)
  #                       .without_count

  #   @submissions = Submission.where(atcoder_user_id: @atcoder_user.id)
  #                               .includes(:contest, :problem, :atcoder_user)
  #                               .order(epoch_second: :desc)
  #                               .page(params[:submissions])
  #                               .per(30)
  #                               .without_count

  #   render 'api/v1/users/show.json.jb'
  # end

  def submissions
    @user = User.find(params[:id])
    @atcoder_user = @user.atcoder_user
    @submissions = Submission.where(atcoder_user_id: @atcoder_user.id)
                                .includes(:contest, :problem, :atcoder_user)
                                .order(epoch_second: :desc)
                                .page(params[:page])
                                .per(30)
                                .without_count

    render 'api/v1/users/submissions.json.jb'
  end

  def contests
    @user = User.find(params[:id])
    @atcoder_user = @user.atcoder_user
    @histories = History.where(atcoder_user_id: @atcoder_user.id)
                        .includes(:contest)
                        .order(end_time: :desc)
                        .page(params[:page])
                        .per(30)
                        .without_count

    render 'api/v1/users/contests.json.jb'
  end

  # TODO: jbも削除する
  # def atcoder_user
  #   logger.debug current_user.user_name

  #   @user = User.find(params[:id])
  #   @atcoder_user = @user.atcoder_user

  #   render 'api/v1/users/atcoder_user.json.jb'
  # end

  def update
    @user ||= User.find(params[:id])
    atcoder_id = params["atcoder_id"]
    @atcoder_user = AtcoderUser.find_or_create_by(atcoder_id: atcoder_id)

    if @atcoder_user.valid?
      @user.update!(atcoder_user: @atcoder_user)

      render 'api/v1/sessions/auth_user.json.jb'
    else
      error! status: 404, message: 'AtCoder IDが存在しません'
    end
  end

  # def index
  #   @users = User.order(id: :asc).page(params[:page]).per(30)

  #   render 'api/v1/users/index.json.jb'
  # end

  # def destroy
  #   User.find(params[:id]).destroy
  #   # flash[:success] = "User deleted"
  #   # redirect_to users_url
  #   render 'api/v1/success.json.jb', code: 200, message: 'User deleted'
  # end

  def following
    @user = User.find(params[:id])
    @atcoder_users = @user.following.page(params[:page]).per(30)
    render 'api/v1/users/following.json.jb'
  end

  private
    # TODO: 整備する
    def correct_user
      @user = User.find(params[:id])
      error!(status: 401, message: 'Unauthorized') if current_user != @user
    end

  #   def admin_user
  #     # redirect_to(root_url) unless current_user.admin?
  #     render('api/v1/error.json.jb', code: 403, message: 'Forbidden') unless current_user.admin?
  #   end
end
