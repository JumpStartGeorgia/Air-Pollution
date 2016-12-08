class AddPledgeCount < ActiveRecord::Migration
  def change
    add_column :pledges, :pledge_count, :integer, default: 0

    create_table :pledge_users do |t|
      t.integer :user_id
      t.integer :pledge_id

      t.timestamps null: false
    end

    add_index :pledge_users, :pledge_id
    add_index :pledge_users, :user_id

  end
end
