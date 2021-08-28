class API::V1::Admin::AtcoderUsersController < API::V1::Admin::BaseController
  def index
    @atcoder_users = AtcoderUser.order(id: :desc).page(params[:page]).per(30).without_count
    @count = AtcoderUser.count if params[:withCount]
    render 'api/v1/admin/atcoder_users.json.jb'
  end
end
