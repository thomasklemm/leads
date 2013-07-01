class Author < ActiveRecord::Base
  def self.import(screen_name)
    user = Twitter.user(screen_name)
    raise user.inspect
  end
end
