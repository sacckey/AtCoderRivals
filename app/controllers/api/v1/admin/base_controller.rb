class API::V1::Admin::BaseController < API::V1::BaseController
  before_action :admin_authenticate_user

  def admin_authenticate_user
    error!(status: 401, message: 'Unauthorized') if !current_user.admin?
  end
end
