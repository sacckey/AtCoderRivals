class AtcoderUser < ApplicationRecord
  has_many :histories, dependent: :destroy
  has_many :contests, through: :histories
  has_many :submissions, dependent: :destroy

  validates :atcoder_id, presence: { message: "ID does not exist." }

  after_initialize :fetch_image_url_and_rating, if: :new_record?
  after_create :fetch_atcoder_user_info

  def fetch_image_url_and_rating
    return self.atcoder_id = nil if self.atcoder_id.match?(/[^A-Za-z0-9_]+/)

    html = APIClient.new.fetch_atcoder_user_page(self.atcoder_id)
    return self.atcoder_id = nil if html.blank?

    doc = Nokogiri::HTML.parse(html)
    self.image_url = doc.at_css('.avatar').attribute('src').value
    self.rating = doc.css("#main-container > div.row > div.col-md-9.col-sm-12 > table > tr:nth-child(2) > td > span").children.text.to_i
  end

  def fetch_atcoder_user_info
    FetchAtcoderUserInfoJob.perform_later(self)
  end

  def self.update_rating
    AtcoderUser.find_each do |atcoder_user|
      next if atcoder_user.histories.blank?
      new_rating = atcoder_user.histories.order(end_time: :desc).first.new_rating
      atcoder_user.update!(rating: new_rating)
    end
  end

  private
end
