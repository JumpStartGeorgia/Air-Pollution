class MakePostedAtTime < ActiveRecord::Migration
  def up
    remove_index :stories, :posted_at
    change_column :stories, :posted_at, :datetime
    add_index :stories, :posted_at 

    remove_index :pledges, :posted_at
    change_column :pledges, :posted_at, :datetime
    add_index :pledges, :posted_at 
  end

  def down
    remove_index :stories, :posted_at
    change_column :stories, :posted_at, :date
    add_index :stories, :posted_at 

    remove_index :pledges, :posted_at
    change_column :pledges, :posted_at, :date
    add_index :pledges, :posted_at 
  end
end
