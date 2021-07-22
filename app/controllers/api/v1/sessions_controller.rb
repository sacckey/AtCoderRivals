class API::V1::SessionsController < API::V1::BaseController
  skip_before_action :authenticate_user, only: [:create, :sample_login]

  FIREBASE_API_KEY = ENV.fetch('FIREBASE_API_KEY')
  REFRESH_TOKEN = ENV.fetch('REFRESH_TOKEN')

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

  def sample_login
    set_sample_user_payload
    raise ArgumentError, 'BadRequest Parameter' if payload.blank?

    uid = payload['sub']
    @user = User.find_or_initialize_by(uid: uid)

    @user.provider = payload['firebase']['sign_in_provider']
    @user.atcoder_user ||= AtcoderUser.find_by(atcoder_id: 'chokudai')
    @user.user_name = 'Sample User'
    @user.image_url = '/icon.png'

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
    @token = REDIS.get('sample_user:token')
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

    def set_sample_user_payload
      token = REDIS.get('sample_user:token')
      @payload = FirebaseIdToken::Signature.verify token
      return if @payload.present?

      token = get_sample_user_token
      return if token.blank?

      @payload = FirebaseIdToken::Signature.verify token
      REDIS.set('sample_user:token', token) if @payload.present?
    end

    def get_sample_user_token
      begin
        # TODO: timeoutを設定する
        res = Faraday.post("https://securetoken.googleapis.com/v1/token?key=#{FIREBASE_API_KEY}") do |req|
          req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
          req.body = "grant_type=refresh_token&refresh_token=#{REFRESH_TOKEN}"
        end

        token = JSON.parse(res.body)['id_token']
        return token
      rescue => e
        return nil
      end
    end
end
