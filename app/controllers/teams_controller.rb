class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      # 保存の成功をここで扱う。
    else
      render 'new'
    end
  end

  private

    def team_params
      params.require(:team).permit(:name, :password, :password_confirmation)
    end
end
