class Tweet < ActiveRecord::Base
  belongs_to :author, counter_cache: true

  # Returns a tweet record
  def self.from_twitter(status)
    tweet = self.find_or_create_by(twitter_id: status.id)
    tweet.assign_fields(status)
    tweet.save! and tweet
  rescue ActiveRecord::RecordNotUnique
    retry
  end

  # Assigns fields from a Twitter::Tweet object
  def assign_fields(status)
    self.text = status.text
    self.in_reply_to_user_id = status.in_reply_to_user_id
    self.in_reply_to_status_id = status.in_reply_to_status_id
    self.source = status.source
    self.retweet_count = status.retweet_count
    self.author = Author.from_twitter(status.user)
    self
  end
end
