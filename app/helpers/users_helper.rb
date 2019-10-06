module UsersHelper
  def show_icon(user)
    image_tag(user.image_url, alt: user.user_name, class: "gravatar")
  end
end
