class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.integer :twitter_id, limit: 8

      t.text :screen_name
      t.text :name

      t.text :description
      t.text :location
      t.text :profile_image_url

      t.integer :followers_count, default: 0
      t.integer :statuses_count, default: 0
      t.integer :friends_count, default: 0

      t.datetime :joined_twitter_at

      t.text :lang
      t.text :time_zone

      t.boolean :verified
      t.boolean :following

      t.integer :tweets_count, default: 0

      t.timestamps
    end
  end
end
