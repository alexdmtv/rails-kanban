module SvgHelper
  def svg_tag(icon_name, **options)
    file = File.read(Rails.root.join("app/assets/images/#{icon_name}.svg"))
    return '(not found)' unless file

    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'

    options.each { |key, val| svg[key.to_s] = val }

    doc.to_html.html_safe
  end
end
