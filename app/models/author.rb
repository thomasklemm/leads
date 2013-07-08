class Author < ActiveRecord::Base
  include UrlExpander 

  # Kaminari
  # paginates_per 100
  # max_paginates_per 250

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

  # Returns an author record
  # or nil if the user cannot be found on Twitter
  def self.find_or_fetch_by_screen_name(screen_name)
    author = find_by(screen_name: screen_name)
    author ||= fetch_by_screen_name(screen_name)
  end

  def self.fetch_by_screen_name(screen_name)
    twitter_user = Twitter.user(screen_name)
    self.from_twitter(twitter_user)
  rescue Twitter::Error::NotFound
    nil
  end

  # Assigns fields from a Twitter::User object
  def assign_fields(user)
    self.screen_name = user.screen_name
    self.name = user.name
    description_urls = user.attrs[:entities].try(:fetch, :description).try(:fetch, :urls, nil)
    self.description = expand_urls(user.description, description_urls)
    self.location = user.location
    self.profile_image_url = user.profile_image_url_https
    url_urls = user.attrs[:entities].try(:fetch, :url).try(:fetch, :urls, nil)    
    self.url = expand_urls(user.url, url_urls)
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

  def fetch_user
    user = Twitter.user(screen_name)
    Author.from_twitter(user)
  end

  # Removes all current tweets
  # and fetches the most recent 200 tweets for the given user
  def fetch_user_timeline
    tweets.destroy_all

    statuses = Twitter.user_timeline(screen_name, count: 200)
    Tweet.many_from_twitter(statuses)
  end

  def to_param
    screen_name
  end
end
