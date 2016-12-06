class AddCountIndex < ActiveRecord::Migration
  def change
    add_index :stories, :impressions_count
    add_index :pledges, :impressions_count
  end
end
