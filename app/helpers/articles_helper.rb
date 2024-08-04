module ArticlesHelper
  def link_to_blank(text, url, **attrs, &)
    link_to(text, url, **attrs.merge(target: "_blank", rel: "noopener noreferrer"), &)
  end

  def render_code_block_app_file(filename, **)
    case @format
    when :atom
      render CodeBlock::AppFileBasic.new(filename, **)
    else
      render CodeBlock::AppFile.new(filename, **)
    end
  end

  def example_color_scheme_css
    color_scheme = ColorScheme.find_by(name: "Custom Watercourse") || ColorScheme.cached_default
    ColorSchemes::Css.new(color_scheme: color_scheme).call
  end
end
