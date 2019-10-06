class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:show,:edit,:update]
  before_action :admin_user, only: [:index,:destroy]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
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

  private

    def user_params
      params.require(:user).permit(:atcoder_id)
    end

    # before action
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
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
