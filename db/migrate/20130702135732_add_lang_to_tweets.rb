class AddLangToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :lang, :text
    add_column :tweets, :favorite_count, :integer, default: 0
  end
end
