class AtcoderUser < ApplicationRecord
  has_many :histories, dependent: :destroy
  has_many :contests, through: :histories
  has_many :submissions, dependent: :destroy

  validates :atcoder_id, presence: { message: "ID does not exist." }
  validates :accepted_count, presence: true
  validates :accepted_count_rank, presence: true
  validates :rated_point_sum, presence: true
  validates :rated_point_sum_rank, presence: true
  validates :image_url, presence: true
  validates :rating, presence: true

  def set_info
    if set_image_url_and_rating
      APIClient.new.get_atcoder_user_info(self)
    else
      self.atcoder_id = nil
    end
  end

  def set_image_url_and_rating
    uri = URI.parse(URI.encode "https://atcoder.jp/users/#{atcoder_id}")
    html = APIClient.new.call_api(uri)
    return if html.blank?

    doc = Nokogiri::HTML.parse(html)
    self.image_url = doc.at_css('.avatar').attribute('src').value
    # TODO: ragingはここではなくhistoryの情報から取得するようにする(default: 0にする)
    self.rating = doc.css("#main-container > div.row > div.col-md-9.col-sm-12 > table > tr:nth-child(2) > td > span").children.text.to_i
  end

  private
end