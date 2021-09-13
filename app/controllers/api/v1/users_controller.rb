class API::V1::UsersController < API::V1::BaseController
  before_action :correct_user, only: [:update, :following]

  def update
    atcoder_id = params["atcoder_id"]
    @atcoder_user = AtcoderUser.find_or_create_by(atcoder_id: atcoder_id)

    if @atcoder_user.valid?
      @user.update!(atcoder_user: @atcoder_user)

      render 'api/v1/sessions/auth_user.json.jb'
    else
      error! status: 404, message: 'AtCoder IDが存在しません'
    end
  end

  def following
    @atcoder_users = @user.following.order("relationships.id desc").page(params[:page]).per(30).without_count
    render 'api/v1/users/following.json.jb'
  end

  private
    def correct_user
      @user = User.find(params[:id])
      error!(status: 401, message: 'Unauthorized') if current_user != @user
    end
end
