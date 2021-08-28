class API::V1::Admin::HistoriesController < API::V1::Admin::BaseController
  def index
    @histories = History.order(id: :desc).page(params[:page]).per(30).without_count
    @count = History.count if params[:withCount]
    render 'api/v1/admin/histories.json.jb'
  end
end
