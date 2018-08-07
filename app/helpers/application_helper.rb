module ApplicationHelper
  include Redcarpet

  # Provides the "original" tags for use in the header
  def nav_tags
    Tag.where(original: true)
  end

  # For checking errors in @object.errors?
  def has_error(obj, key)
    obj.errors.details[key].empty? == false
  end

  # Render markdown ¯\_(ツ)_/¯
  def render_markdown(to_render)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    markdown.render(to_render)
  end

end
