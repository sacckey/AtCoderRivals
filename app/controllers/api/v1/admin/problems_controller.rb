class API::V1::Admin::ProblemsController < API::V1::Admin::BaseController
  def index
    @problems = Problem.order(id: :desc).page(params[:page]).per(30).without_count
    @count = Problem.count if params[:withCount]
    render 'api/v1/admin/problems.json.jb'
  end
end
