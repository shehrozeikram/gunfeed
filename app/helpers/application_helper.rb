module ApplicationHelper
  def isActive_path?(link_path)
    if current_page?(link_path)
      "active__class"
    else
      ""
    end
  end
end
