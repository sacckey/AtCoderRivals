class API::V1::UsersController < ApplicationController
  # TODO: 設定する
  # before_action :logged_in_user
  # before_action :correct_user, only: [:show,:edit,:update,:following,:atcoder_user]
  # before_action :admin_user, only: [:index,:destroy]
  before_action :authenticate_user

  def show
    @user = User.find(params[:id])
    @atcoder_user = @user.atcoder_user
    @feed_atcoder_user_ids = @atcoder_user.id
    @contests = @atcoder_user.contests.order(start_epoch_second: :desc).page(params[:contests]).per(30)
    @submissions = @atcoder_user.submissions
                                .includes(:atcoder_user, :contest, :problem)
                                .order(epoch_second: :desc)
                                .page(params[:submissions])
                                .per(30)
                                .without_count

    render 'api/v1/users/show.json.jb'
  end

  # TODO: 消す
  def edit
    @user = User.find(params[:id])
    @atcoder_user = @user.atcoder_user

    render 'api/v1/users/show.json.jb'
  end

  def atcoder_user
    logger.debug current_user.user_name

    @user = User.find(params[:id])
    @atcoder_user = @user.atcoder_user

    render 'api/v1/users/atcoder_user.json.jb'
  end

  def update
    @user = User.find(params[:id])
    atcoder_id = params["atcoder_user"]["atcoder_id"]
    # 入力されたidに';'か' 'が入っていた場合は、それよりも前の英数字列をidにして検索する
    if m = /(\w*)[; ]/.match(atcoder_id)
      atcoder_id = m[1]
    end
    @atcoder_user = AtcoderUser.find_or_create_by(atcoder_id: atcoder_id)

    if @atcoder_user.valid?
      @user.update!(atcoder_user: @atcoder_user)
      # flash[:success] = "Profile updated"
      # redirect_to @user
      # TODO: リダイレクトするように & message
      render 'api/v1/users/atcoder_user.json.jb'
    else
      render 'api/v1/error.json.jb', code: 'code', message: 'message'
    end
  end

  def index
    @users = User.order(id: :asc).page(params[:page]).per(30)

    render 'api/v1/users/index.json.jb'
  end

  def destroy
    User.find(params[:id]).destroy
    # flash[:success] = "User deleted"
    # redirect_to users_url
    render 'api/v1/success.json.jb', code: 200, message: 'User deleted'
  end

  def following
    @user  = User.find(params[:id])
    @atcoder_user = @user.atcoder_user
    # @atcoder_users = @user.following.page(params[:page]).per(30)
    puts 'testtttttttttttttttt'
    p params
    @atcoder_users = AtcoderUser.all.page(params[:page]).per(30)
    render 'api/v1/users/following.json.jb'
  end

  private

    def user_params
      params.require(:user).permit(:atcoder_user_id)
    end

    def correct_user
      unless current_user.admin?
        @user = User.find(params[:id])
        # redirect_to(root_url) unless current_user?(@user)
        render('api/v1/error.json.jb', code: 401, message: 'message') unless current_user?(@user)
      end
    end

    def admin_user
      # redirect_to(root_url) unless current_user.admin?
      render('api/v1/error.json.jb', code: 403, message: 'Forbidden') unless current_user.admin?
    end
end
