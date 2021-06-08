class API::V1::BaseController < ActionController::API
  include Firebase::Auth::Authenticable

  before_action :authenticate_user
end
