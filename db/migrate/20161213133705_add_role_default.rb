class AddRoleDefault < ActiveRecord::Migration
  def change
    change_column :users, :role_id, :integer, limit: 4, default: 1
  end
end
