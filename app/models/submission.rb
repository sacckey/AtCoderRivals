class Submission < ApplicationRecord
  belongs_to :problem, foreign_key: :problem_name, primary_key: :name
  belongs_to :contest, foreign_key: :contest_name, primary_key: :name
  belongs_to :atcoder_user

  validates :epoch_second, presence: true
  validates :problem_name, presence: true
  validates :contest_name, presence: true
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
        begin
          submissions_list << 
          atcoder_user.submissions.build(
            epoch_second: submission["epoch_second"],
            problem_name: submission["problem_id"],
            contest_name: submission["contest_id"],
            language: submission["language"],
            point: submission["point"],
            result: submission["result"]
          )
        rescue
          next
        end
      end
      Submission.import! submissions_list
    end
  end
end