class RenameAuthorsTableToLeads < ActiveRecord::Migration
  def change
    rename_table :authors, :leads
    rename_column :tweets, :author_id, :lead_id
  end
end
