class AddPledgeSlugs < ActiveRecord::Migration
  def change
    add_column :pledges, :slug, :string
    add_column :pledge_translations, :slug, :string

    add_index :pledges, :slug
    add_index :pledge_translations, :slug

  end
end
