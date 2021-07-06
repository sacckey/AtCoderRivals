module API::V1::SessionsHelper
  def request_certificates_if_necessary
    FirebaseIdToken::Certificates.request unless FirebaseIdToken::Certificates.present?
  end
end
