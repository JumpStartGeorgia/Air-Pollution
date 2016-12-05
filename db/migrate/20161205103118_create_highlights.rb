class CreateHighlights < ActiveRecord::Migration
  def up
    create_table :highlights do |t|
      t.boolean :is_public, default: false
      t.datetime :posted_at

      t.timestamps null: false
    end
  
    Highlight.create_translation_table! :title => :string, :url => :string,
                                    image_file_name: :string,
                                    image_content_type: :string

    add_column :highlight_translations, :image_file_size, :integer
    add_column :highlight_translations, :image_updated_at, :datetime

    add_index :highlights, :is_public
    add_index :highlights, :posted_at
    add_index :highlight_translations, :title

  end

  def down
    drop_table :highlights
    Highlight.drop_translation_table!
  end
end
