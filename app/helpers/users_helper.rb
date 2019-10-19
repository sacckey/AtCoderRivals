module UsersHelper
  def show_icon(user)
    image_tag(user.image_url, alt: user.user_name, class: "icon")
  end

  # def show_result(user,contest)
  #   results = user.get_results(contest)
  #   results.each do |result|
  #     if result["UserName"] == user.atcoder_id
  #       return result["Performance"]
  #     end
  #   end
  #   return ""
  # end
  def show_result(history,contest)
    result = history.find_by(contest_id: contest.id)
    if result
      return result.performance
    else
      return ""
    end
  end
end