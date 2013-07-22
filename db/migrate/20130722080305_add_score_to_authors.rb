class AddScoreToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :score, :text
    add_index :authors, :score
  end
end
