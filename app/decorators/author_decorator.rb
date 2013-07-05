class AuthorDecorator < Draper::Decorator
  delegate_all
  delegate :tweets

  def sources
    @sources ||= sources!
  end

  def sources!
    @sources = begin
      sources = tweets.group("source").count.sort_by(&:last).reverse
      sources &&= sources.map{ |source, count| [ source, h.number_to_percentage((count * 100 / sources.map(&:last).sum.to_f), precision: 0) ] }
      sources &&= sources.map{ |source, percentage| "#{ source } (#{ percentage })" }
      sources.to_sentence(words_connector: ',<br>', two_words_connector: ',<br>', last_word_connector: ',<br>').html_safe
    end
  end

  def linked_description
    h.link_twitter_text(model.description)
  end

  def statuses_count
    h.number_with_delimiter(super)
  end

  def followers_count
    h.number_with_delimiter(super)
  end

  def friends_count
    h.number_with_delimiter(super)
  end

  def joined_twitter_on
    joined_twitter_at.to_date.to_s(:long)
  end

  def grouped_tweets_sources
    tweets.group('source').count.map { |k,v| [h.strip_links(k.dup), v] }
  end

  def ordered_tweets
    tweets.order(created_at: :desc).limit(100).decorate
  end

  def response_rate
    @response_rate ||= response_rate!
  end

  def response_rate!
    @response_rate = begin
      replies = tweets.map(&:in_reply_to_status_id).compact.length
      total = tweets.size
      h.number_to_percentage(replies*100 / total, precision: 1)
    end
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
