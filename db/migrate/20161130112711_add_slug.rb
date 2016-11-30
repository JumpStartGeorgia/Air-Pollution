class AddSlug < ActiveRecord::Migration
  def change
    add_column :stories, :slug, :string
    add_column :story_translations, :slug, :string

    add_index :stories, :slug
    add_index :story_translations, :slug

  end
end
