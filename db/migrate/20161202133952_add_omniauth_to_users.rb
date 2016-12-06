class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :nickname, :string
    add_column :users, :avatar, :string
    add_index :users, [:provider, :uid], :name => 'idx_users_provider'
  end
end
