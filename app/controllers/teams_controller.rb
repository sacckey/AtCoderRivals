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
      flash[:success] = "Welcome to the AtCoder Rivals!"
      redirect_to @team
    else
      render 'new'
    end
  end

  private

    def team_params
      params.require(:team).permit(:name, :password, :password_confirmation)
    end
end
