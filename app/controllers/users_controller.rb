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
    @atcoder_user = AtcoderUser.find_or_create_atcoder_user(atcoder_id)

    if @atcoder_user.valid?
      History.create_history(@atcoder_user)
      Submission.create_submissions(@atcoder_user)
      @user.update_attributes!(atcoder_user_id: @atcoder_user.id)
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
