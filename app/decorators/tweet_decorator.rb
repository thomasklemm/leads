class TweetDecorator < Draper::Decorator
  delegate_all

  def text
    h.link_twitter_text(model.text)
  end

  def source
    model.source.html_safe
  end

  def created_at
    "#{ h.time_ago_in_words(model.created_at) } ago"
  end

  def twitter_url
    "https://twitter.com/#{ lead.screen_name }/status/#{ twitter_id }"
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
