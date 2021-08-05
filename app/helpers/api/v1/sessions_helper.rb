module API::V1::SessionsHelper
  def request_certificates_if_necessary
    FirebaseIdToken::Certificates.request unless FirebaseIdToken::Certificates.present?
  end

  def error!(status:, message:)
    @status = status
    @message = message
    render 'api/v1/error.json.jb', status: @status
  end
end
