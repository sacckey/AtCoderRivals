class API::V1::BaseController < ActionController::API
  include Firebase::Auth::Authenticable
  include API::V1::SessionsHelper

  before_action :request_certificates_if_necessary
  before_action :authenticate_user
end
