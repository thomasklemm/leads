class AddLeadFlagToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :lead, :boolean, default: false
  end
end
