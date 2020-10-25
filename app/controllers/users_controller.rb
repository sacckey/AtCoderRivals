class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:show,:edit,:update,:following]
  before_action :admin_user, only: [:index,:destroy]

  def show
    @user = User.find(params[:id])
    @atcoder_user = @user.atcoder_user
    @feed_atcoder_user_ids = @atcoder_user.id
    @contests = @atcoder_user.contests.order(start_epoch_second: :desc).paginate(page: params[:contests])
    @submissions = @atcoder_user.submissions
                                .includes(:atcoder_user, :contest, :problem)
                                .order(epoch_second: :desc)
                                .paginate(page: params[:submissions])
  end

  def edit
    @user = User.find(params[:id])
    @atcoder_user = @user.atcoder_user
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
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @atcoder_user = @user.atcoder_user
    @atcoder_users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:atcoder_user_id)
    end

    def correct_user
      unless current_user.admin?
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
      end
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
