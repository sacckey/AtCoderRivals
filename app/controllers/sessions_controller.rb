class SessionsController < ApplicationController
  def new
  end

  def create
    team = Team.find_by(name: params[:session][:name].downcase)
    if team && team.authenticate(params[:session][:password])
      # チームログイン後にチーム情報のページにリダイレクトする
      log_in team
      redirect_to team
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'Invalid name/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
