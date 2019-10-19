class Submission < ApplicationRecord
  belongs_to :problem
  belongs_to :contest
  belongs_to :atcoder_user

  validates :epoch_second, presence: true
  validates :problem_id, presence: true
  validates :contest_id, presence: true
  validates :atcoder_user_id, presence: true
  validates :language, presence: true
  validates :point, presence: true
  validates :result, presence: true

  default_scope -> { order(epoch_second: :desc) }

  def self.create_submissions(atcoder_user)
    if atcoder_user.submissions.empty?
      submissions = atcoder_user.get_submissions
      submissions_list = []
      submissions.each do |submission|
        submissions_list << 
        atcoder_user.submissions.build(
          epoch_second: submission["epoch_second"],
          problem_id: Problem.find_by(problem_name: submission["problem_id"]).id,
          contest_id: Contest.find_by(abbreviation: submission["contest_id"]).id,
          language: submission["language"],
          point: submission["point"],
          result: submission["result"]
        )
      end
      Submission.import submissions_list
    end
  end
end