class API::V1::Admin::UsersController < API::V1::Admin::BaseController
  def index
    @users = User.order(id: :desc).page(params[:page]).per(30).without_count
    @count = User.count if params[:withCount]
    render 'api/v1/admin/users.json.jb'
  end
end
