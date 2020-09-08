class AtcoderUsersController < ApplicationController
  before_action :logged_in_user, only: [:search]

  def search
    return unless atcoder_id = params[:search]

    # 入力されたidに';'か' 'が入っていた場合は、それよりも前の英数字列をidにして検索する
    # TODO: ifなしでできない？
    if m = /(\w*)[; ]/.match(atcoder_id)
      atcoder_id = m[1]
    end

    @atcoder_user = AtcoderUser.find_or_initialize_by(atcoder_id: atcoder_id)
    @atcoder_user.set_info if is_new_user = @atcoder_user.new_record?

    if @atcoder_user.valid? && is_new_user
      # TODO: sidekiqに積む
      api_client = APIClient.new
      api_client.get_user_history(@atcoder_user)
      api_client.get_user_submissions(@atcoder_user)
    end
  end
end