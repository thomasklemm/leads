require 'spec_helper'

describe Tweet do
  describe ".from_twitter(Twitter::Tweet.new)" do
    it "creates the given author and assigns fields" do
      VCR.use_cassette('statuses/351779153646858241') do
        # Tweet
        status = Twitter.status('351779153646858241')
        tweet = Tweet.from_twitter(status)

        expect(tweet.twitter_id).to eq(status.id)
        expect(tweet.in_reply_to_user_id).to eq(status.in_reply_to_user_id)
        expect(tweet.in_reply_to_status_id).to eq(status.in_reply_to_status_id)
        expect(tweet.source).to eq(status.source)
        expect(tweet.retweet_count).to eq(status.retweet_count)

        expect{ Tweet.from_twitter(status) }.to_not raise_error

        # Author
        user = status.user
        author = tweet.author

        expect(author.twitter_id).to eq(user.id)
        expect(author.screen_name).to eq(user.screen_name)
        expect(author.name).to eq(user.name)
        expect(author.description).to eq(user.description)
        expect(author.location).to eq(user.location)
        expect(author.profile_image_url).to eq(user.profile_image_url_https)
        expect(author.url).to eq(user.url)
        expect(author.followers_count).to eq(user.followers_count)
        expect(author.statuses_count).to eq(user.statuses_count)
        expect(author.friends_count).to eq(user.friends_count)
        expect(author.joined_twitter_at).to eq(user.created_at)
        expect(author.lang).to eq(user.lang)
        expect(author.time_zone).to eq(user.time_zone)
        expect(author.verified).to eq(user.verified)
        expect(author.following).to eq(user.following)

        expect{ Author.from_twitter(user) }.to_not raise_error
      end
    end
  end
end
