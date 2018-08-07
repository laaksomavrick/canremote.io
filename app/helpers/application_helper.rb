module ApplicationHelper
  include Redcarpet

  # Provides the "original" tags for use in the header
  def nav_tags
    Tag.where(original: true)
  end

  # Render markdown ¯\_(ツ)_/¯
  def render_markdown(to_render)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    markdown.render(to_render)
  end

end
