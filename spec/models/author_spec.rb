require 'spec_helper'

describe Author do
  describe ".from_twitter(Twitter::User.new)" do
    it "creates the given author and assigns fields" do
      VCR.use_cassette('users/simyo') do
        # Author
        user = Twitter.user('simyo')
        author = Author.from_twitter(user)

        expect(author.twitter_id).to eq(user.id)
        expect(author.screen_name).to eq(user.screen_name)
        expect(author.name).to eq(user.name)
        expect(author.description).to eq("Der offizielle simyo Deutschland Twitter-Account. http://www.simyo.de/de/unternehmen/impressum.html") # expanded url
        expect(author.location).to eq(user.location)
        expect(author.profile_image_url).to eq(user.profile_image_url_https)
        expect(author.url).to eq("http://www.simyo.de/") # expanded url
        expect(author.followers_count).to eq(user.followers_count)
        expect(author.statuses_count).to eq(user.statuses_count)
        expect(author.friends_count).to eq(user.friends_count)
        expect(author.joined_twitter_at).to eq(user.created_at)
        expect(author.lang).to eq(user.lang)
        expect(author.time_zone).to eq(user.time_zone)
        expect(author.verified).to eq(user.verified)
        expect(author.following).to eq(user.following)

        expect{ Author.from_twitter(user) }.to_not raise_error

        # Free tweet
        status = user.status
        tweet = author.tweets.first

        expect(tweet.text).to eq(status.text)

        expect{ Tweet.from_twitter(status) }.to_not raise_error
      end
    end
  end
end
