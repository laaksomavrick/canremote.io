module ApplicationHelper

  def nav_tags
    Tag.where(original: true)
  end

  def has_error(obj, key)
    obj.errors.details[key].empty? == false
  end

end
