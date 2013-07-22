class SetDefaultScoreOnAuthors < ActiveRecord::Migration
  def up
    Author.update_all(score: 'unscored')
  end

  def down
    Author.update_all(score: nil)
  end
end
