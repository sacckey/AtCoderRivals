class API::V1::SessionsController < API::V1::BaseController
  skip_before_action :authenticate_user, only: [:create]

  def auth_user
    @user = current_user
    @atcoder_user = current_user.atcoder_user

    render 'api/v1/sessions/auth_user.json.jb'
  end

  def create
    raise ArgumentError, 'BadRequest Parameter' if payload.blank?

    twitter_uid = payload['firebase']['identities']['twitter.com'].first
    @user = User.find_or_initialize_by(twitter_uid: twitter_uid)
    first_login = @user.new_record?

    @user.provider = payload['firebase']['sign_in_provider']
    @user.uid = payload['sub']
    @user.user_name = payload['name']
    @user.image_url = payload['picture']
    @user.atcoder_user ||= AtcoderUser.find_by(atcoder_id: 'chokudai')

    if @user.save
      puts 'success'
      # TODO: first_loginかどうかを返す
      # render json: @user, status: :ok
    else
      puts 'error'
      p @user.errors
      # render json: @user.errors, status: :unprocessable_entity
    end

    # render 'api/v1/success.json.jb'
    @atcoder_user = @user.atcoder_user
    render 'api/v1/sessions/auth_user.json.jb'
  end

  private

    def sign_up_params
      params.require(:registration).permit(:user_name, :display_name)
    end

    def token_from_request_headers
      request.headers['Authorization']&.split&.last
    end

    def token
      params[:token] || token_from_request_headers
    end

    def payload
      @payload ||= FirebaseIdToken::Signature.verify token
    end
end
