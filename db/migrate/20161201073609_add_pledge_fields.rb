class AddPledgeFields < ActiveRecord::Migration
  
  def up
    rename_column :pledge_translations, :text, :why_care
    add_column :pledge_translations, :what_it_is, :text
    add_column :pledge_translations, :what_you_do, :text
    
  end

  def down
    rename_column :pledge_translations, :why_care, :text
    remove_column :pledge_translations, :what_it_is
    remove_column :pledge_translations, :what_you_do
  end
end
