class Author < ActiveRecord::Base
  has_many :tweets, dependent: :restrict_with_exception

  # Returns an author record
  def self.from_twitter(user)
    author = self.find_or_create_by(twitter_id: user.id)
    author.assign_fields(user)
    author.save! and author
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
end
