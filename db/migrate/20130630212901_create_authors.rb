class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.integer :twitter_id, limit: 8

      t.text :screen_name
      t.text :name

      t.text :description
      t.text :location
      t.text :profile_image_url
      t.text :url

      t.integer :followers_count, default: 0
      t.integer :statuses_count, default: 0
      t.integer :friends_count, default: 0

      t.datetime :joined_twitter_at

      t.text :lang
      t.text :time_zone

      t.boolean :verified
      t.boolean :following

      t.timestamps
    end

    add_index :authors, :twitter_id, unique: true
    add_index :authors, :screen_name
    add_index :authors, :followers_count
  end
end
