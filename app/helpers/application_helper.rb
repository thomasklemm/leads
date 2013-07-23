module ApplicationHelper
  def link_to_add_fields(name, f, type)
    new_object = f.object.send "build_#{type}"
    id = "new_#{type}"
    fields = f.send("#{type}_fields", new_object, child_index: id) do |builder|
      render(type.to_s + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def link_twitter_text(text)
    user_options = { username_include_symbol: true }
    text = Twitter::Autolink.auto_link_urls(text, url_target: :blank)
    text = Twitter::Autolink.auto_link_usernames_or_lists(text, user_options)
    simple_format(text)
  end

  # Returns a font-awesome icon tag
  def icon_tag(type, text=nil)
    "<i class='icon-#{ type.to_s }'></i> #{ text }".html_safe
  end

  def score_icon_tag(score)
    case score.to_s
    when 'high'      then icon_tag('star')
    when 'medium'    then icon_tag('star-half-full')
    when 'secondary' then icon_tag('star-empty')
    else                  icon_tag('ok')
    end
  end
end
