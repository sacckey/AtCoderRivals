class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    @first_login = false
    log_in(user)
    flash[:success] = "Welcome to the AtCoder Rivals!"
    
    # 初めてのログインの際はID設定ページに遷移する
    if user.first_login
      user.first_login = false
      flash[:success] += " Please update your AtCoder ID."
      redirect_to edit_user_path(user)
    else
      redirect_to user
    end
  end

  def login_as_sample_user
    user = User.find(1)
    log_in(user)
    flash[:success] = "Welcome to the AtCoder Rivals!"
    redirect_to user
  end

  def failure
    flash[:danger] = 'Authentication failed.'
    redirect_to login_path
  end

  def destroy
    log_out
    flash[:success] = "Logged out"
    redirect_to root_path
  end
end
