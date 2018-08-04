module ApplicationHelper

  def nav_tags
    Tag.where(original: true)
  end

end
