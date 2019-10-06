class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    log_in(user)
    flash[:success] = "Welcome to the AtCoder Rivals!"
    redirect_to user
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
