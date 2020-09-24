class AtcoderUsersController < ApplicationController
  before_action :logged_in_user, only: [:search]

  def search
    return unless atcoder_id = params[:search]

    # 入力されたidに';'か' 'が入っていた場合は、それよりも前の英数字列をidにして検索する
    # TODO: ifなしでできない？
    if m = /(\w*)[; ]/.match(atcoder_id)
      atcoder_id = m[1]
    end

    @atcoder_user = AtcoderUser.find_or_create_by(atcoder_id: atcoder_id)
  end
end