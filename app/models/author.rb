class Author < ActiveRecord::Base
  # Kaminari
  paginates_per 100
  max_paginates_per 250

  has_many :tweets, dependent: :restrict_with_exception

  # Returns an author record
  def self.from_twitter(user, opts={})
    return unless user

    author = self.find_or_create_by(twitter_id: user.id)
    author.assign_fields(user)
    author.save!

    # Free embeded status
    Tweet.from_twitter(user.status, author) unless opts[:skip_status]

    author
  rescue ActiveRecord::RecordNotUnique
    retry
  end

  # Assigns fields from a Twitter::User object
  def assign_fields(user)
    self.screen_name = user.screen_name
    self.name = user.name
    self.description = user.description
    self.location = user.location
    self.profile_image_url = user.profile_image_url_https
    self.url = user.url
    self.followers_count = user.followers_count
    self.statuses_count = user.statuses_count
    self.friends_count = user.friends_count
    self.joined_twitter_at = user.created_at
    self.lang = user.lang
    self.time_zone = user.time_zone
    self.verified = user.verified
    self.following = user.following
    self
  end

  def at_screen_name
    "@#{ screen_name }"
  end

  def twitter_url
    "https://twitter.com/#{ screen_name }"
  end

  def sources
    @sources ||= sources!
  end

  def sources!
    sources = tweets.group("source").count.sort_by(&:last).reverse
    sources &&= sources.map{ |source, count| [ source, ActionController::Base.helpers.number_to_percentage((count * 100 / sources.map(&:last).sum.to_f), precision: 0) ] }
    sources &&= sources.map{ |source, percentage| "#{ percentage } #{ source }" }
    sources.to_sentence(words_connector: ',<br>', two_words_connector: ',<br>', last_word_connector: ',<br>').html_safe
  end

  def mark_as_lead!
    self.lead = true
    save!
    self
  end

  def to_param
    screen_name
  end
end
