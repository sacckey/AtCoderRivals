class API::V1::Admin::ContestsController < API::V1::Admin::BaseController
  def index
    @contests = Contest.order(id: :desc).page(params[:page]).per(30).without_count
    @count = Contest.count if params[:withCount]
    render 'api/v1/admin/contests.json.jb'
  end
end
