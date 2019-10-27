module ApplicationHelper
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

  def color(rate)
    if rate <= 399
      "rate_gray"
    elsif rate <= 799
      "rate_brown"
    elsif rate <= 1199
      "rate_green"
    elsif rate <= 1599
      "rate_cyan"
    elsif rate <= 1999
      "rate_blue"
    elsif rate <= 2399
      "rate_yellow"
    elsif rate <= 2799
      "rate_orange"
    else
      "rate_red"
    end
  end

  def atcoder_user_url(atcoder_id)
    "https://atcoder.jp/users/#{atcoder_id}"
  end

  def contest_url(contest_name)
    "https://atcoder.jp/contests/#{contest_name}"
  end

  def problem_url(contest_name, problem_name)
    "https://atcoder.jp/contests/#{contest_name}/tasks/#{problem_name}"
  end

  def standings_url(contest_name, atcoder_id)
    "https://atcoder.jp/contests/#{contest_name}/standings?watching=#{atcoder_id}"
  end

  
end
