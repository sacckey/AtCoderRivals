class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:show,:edit,:update,:following]
  before_action :admin_user, only: [:index,:destroy]

  def show
    @user = User.find(params[:id])
    @atcoder_user = @user.atcoder_user
    @history = @atcoder_user.histories
    @contests = @atcoder_user.contests.paginate(page: params[:contests])
    @submissions = @atcoder_user.submissions.paginate(page: params[:submissions])
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
    @atcoder_user = AtcoderUser.find_or_initialize_by(atcoder_id: atcoder_id)
    @atcoder_user.set_info if is_new_user = @atcoder_user.new_record?

    if @atcoder_user.valid?
      if is_new_user
        # TODO: sidekiqに積む
        api_client = APIClient.new
        api_client.get_user_history(@atcoder_user)
        api_client.get_user_submissions(@atcoder_user)
      end

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
