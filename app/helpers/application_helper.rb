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

  # Highlights the currently active navigation item with a special class
  def active_list_item_link_to(*args)
    link = link_to(*args)
    path_args = args.second or raise StandardError, 'Expected URL to be second argument.'
    exact = args.third.try(:fetch, :exact, false)

    match = if exact
      current_path == url_for(path_args)
    else
      current_path.start_with?(url_for(path_args))
    end

    content_tag(:li, link, class: "#{ 'active' if match }")
  end

  def logo_header(text)
    content_tag :h3, class: 'logo-header' do
      concat image_tag 'Tweetbox-Logo.png'
      concat text
    end

    # "<h3>#{ image_tag 'Tweetbox-Logo.png', width: 42, style: 'margin-right: 8px' }#{ text }</h3>".html_safe
  end

  private

  def current_path
    request.fullpath
  end
end
