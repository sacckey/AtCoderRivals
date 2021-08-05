class API::V1::AtcoderUsersController < API::V1::BaseController
  def follow
    @atcoder_user = AtcoderUser.find(params[:id])
    current_user.follow(@atcoder_user)
    render 'api/v1/success.json.jb'
  end

  def unfollow
    @atcoder_user = AtcoderUser.find(params[:id])
    current_user.unfollow(@atcoder_user)
    render 'api/v1/success.json.jb'
  end

  def search
    @atcoder_user = AtcoderUser.find_or_create_by(atcoder_id: params[:atcoder_id])

    if @atcoder_user.valid?
      @is_following = current_user.following?(@atcoder_user)

      render 'api/v1/atcoder_users/atcoder_user.json.jb'
    else
      error! status: 404, message: 'AtCoder IDが存在しません'
    end
  end
end
