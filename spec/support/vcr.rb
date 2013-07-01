VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join("spec", "vcr")
  c.hook_into :webmock

  c.filter_sensitive_data('<TWITTER_CONSUMER_KEY>')    { ENV['TWITTER_CONSUMER_KEY'] }
  c.filter_sensitive_data('<TWITTER_CONSUMER_SECRET>') { ENV['TWITTER_CONSUMER_SECRET'] }

  c.filter_sensitive_data('<TWITTER_OAUTH_TOKEN>')        { ENV['TWITTER_OAUTH_TOKEN'] }
  c.filter_sensitive_data('<TWITTER_OAUTH_TOKEN_SECRET>') { ENV['TWITTER_OAUTH_TOKEN_SECRET'] }
end
