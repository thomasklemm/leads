# Fetches and updates all verified Twitter accounts from Twitter
# Retrieves the accounts in batches of 100 and also adds
# one new tweet for each run for free
class VerifiedWorker
  def self.perform(next_cursor=nil)
    friend_ids = Twitter.friend_ids('verified', cursor: next_cursor)

    user_ids = []
    friend_ids.ids.each_slice(100) { |ids| user_ids << ids }

    (0..49).each do |i|
      users = Twitter.users(user_ids[i], method: :get)
      users.each { |user| Lead.from_twitter(user) }
    end

    next_cursor = friend_ids.try(:next)
    self.perform(next_cursor) if next_cursor.present?

    true
  end
end


