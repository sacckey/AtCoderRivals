class AtcoderUser < ApplicationRecord
  has_many :histories, dependent: :destroy
  has_many :contests, through: :histories
  has_many :submissions, dependent: :destroy

  validates :atcoder_id, presence: { message: "ID does not exist." }

  after_initialize :set_info, if: :new_record?
  after_create :get_history_and_submissions

  def set_info
    @api_client = APIClient.new
    return unless set_image_url_and_rating

    @api_client.set_atcoder_user_info(self)
  end

  def set_image_url_and_rating
    uri = URI.parse(URI.encode "https://atcoder.jp/users/#{atcoder_id}")
    html = @api_client.call_api(uri)
    return self.atcoder_id = nil if html.blank?

    doc = Nokogiri::HTML.parse(html)
    self.image_url = doc.at_css('.avatar').attribute('src').value
    # TODO: ragingはここではなくhistoryの情報から取得するようにする(default: 0にする)
    self.rating = doc.css("#main-container > div.row > div.col-md-9.col-sm-12 > table > tr:nth-child(2) > td > span").children.text.to_i
  end

  def get_history_and_submissions
    @api_client ||= APIClient.new
    # TODO: sidekiqに積む
    @api_client.get_user_history(self)
    @api_client.get_user_submissions(self)
  end

  private
end