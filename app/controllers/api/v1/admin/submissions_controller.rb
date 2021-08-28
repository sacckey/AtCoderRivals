class API::V1::Admin::SubmissionsController < API::V1::Admin::BaseController
  def index
    @submissions = Submission.includes(:contest, :problem, :atcoder_user)
                             .order(epoch_second: :desc)
                             .page(params[:page])
                             .per(30)
                             .without_count

    render 'api/v1/admin/submissions.json.jb'
  end
end
