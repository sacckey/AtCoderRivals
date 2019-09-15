module SessionsHelper
  def log_in(team)
    session[:team_id] = team.id
  end

  def current_team
    if session[:team_id]
      @current_team ||= Team.find_by(id: session[:team_id])
    end
  end

  def logged_in?
    !current_team.nil?
  end

  def log_out
    session.delete(:team_id)
    @current_team = nil
  end

end
