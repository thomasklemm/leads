class RemoveTweetsCountFromAuthors < ActiveRecord::Migration
  def up
    remove_column :authors, :tweets_count
  end

  def down
    add_column :authors, :tweets_count, :integer
  end
end
