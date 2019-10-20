module ApplicationHelper
  # ページごとの完全なタイトルを返します。
  def full_title(page_title = '')
    base_title = "AtCoder Rivals"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def show_icon(user, size: 50)
    if user.instance_of? AtcoderUser
      alt = user.atcoder_id
    else
      alt = user.user_name
    end
    image_tag(user.image_url, alt: alt, class: "icon", size: size)
  end
end
