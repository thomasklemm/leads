class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :twitter_id, limit: 8

      t.text :text

      t.integer :in_reply_to_user_id, limit: 8
      t.integer :in_reply_to_status_id, limit: 8

      t.text :source
      t.integer :retweet_count, default: 0

      t.integer :author_id

      t.timestamps
    end

    add_index :tweets, :twitter_id, unique: true
    add_index :tweets, :author_id
  end
end
