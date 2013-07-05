class Tweet < ActiveRecord::Base
  belongs_to :author

  # Returns a tweet record
  def self.from_twitter(status, author=nil)
    return unless status

    tweet = self.find_or_create_by(twitter_id: status.id)
    tweet.assign_fields(status)
    tweet.author = author || Author.from_twitter(status.user, skip_status: true)
    tweet.save! and tweet
  rescue ActiveRecord::RecordNotUnique
    retry
  end

  # Returns an array of tweet records
  def self.many_from_twitter(*statuses)
    statuses.map { |status| from_twitter(status) }
  end

  # Assigns fields from a Twitter::Tweet object
  def assign_fields(status)
    self.text = status.text
    self.in_reply_to_user_id = status.in_reply_to_user_id
    self.in_reply_to_status_id = status.in_reply_to_status_id
    self.source = status.source
    self.lang = status.lang
    self.retweet_count = status.retweet_count
    self.favorite_count = status.favorite_count
    self.created_at = status.created_at
    self
  end
end
