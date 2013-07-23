class SetDefaultScoreOnLeads < ActiveRecord::Migration
  def up
    Lead.update_all(score: 'unscored')
  end

  def down
    Lead.update_all(score: nil)
  end
end
