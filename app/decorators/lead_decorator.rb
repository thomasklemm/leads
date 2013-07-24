class LeadDecorator < Draper::Decorator
  delegate_all
  delegate :tweets

  def at_screen_name
    "@#{ screen_name }"
  end

  def description
    h.link_twitter_text(model.description)
  end

  def url
    h.link_twitter_text(model.url)
  end

  def joined_twitter_on
    joined_twitter_at.to_date.to_s(:long)
  end

  def twitter_url
    "https://twitter.com/#{ screen_name }"
  end

  def response_rate
    @response_rate ||= begin
      replies = tweets.map(&:in_reply_to_status_id).compact.length
      h.number_to_percentage(replies*100 / tweets.size, precision: 1)
    end
  end

  def sources
    @sources ||= begin
      sources = tweets.pluck(:source)
      sources &&= sources.each_with_object({}) { |source, h| h[source] ||= 0; h[source] +=1 }
      sources &&= sources.sort_by { |k, v| v}.reverse.map(&:first)
      sources &&= sources.to_sentence.html_safe
    end
  end

  alias_method :source, :sources

  def weighted_sources
    @weighted_sources ||= begin
      sources = tweets.group("source").count.sort_by(&:last).reverse
      sources &&= sources.map{ |source, count| [ source, h.number_to_percentage((count * 100 / sources.map(&:last).sum.to_f), precision: 0) ] }
      sources &&= sources.map{ |source, percentage| "#{ source } (#{ percentage })" }
      sources.to_sentence(words_connector: ',<br>', two_words_connector: ',<br>', last_word_connector: ',<br>').html_safe
    end
  end

  def grouped_tweets_sources
    tweets.group('source').count.map { |k,v| [h.strip_links(k.dup), v] }
  end

  def ordered_tweets
    tweets.order(created_at: :desc).limit(50)
  end

  def lead_path
    h.lead_path(self)
  end

  def statuses_count
    h.number_with_delimiter(model.statuses_count)
  end

  def followers_count
    h.number_with_delimiter(model.followers_count)
  end

  def friends_count
    h.number_with_delimiter(model.friends_count)
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
