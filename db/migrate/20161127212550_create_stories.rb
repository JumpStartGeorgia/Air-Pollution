class CreateStories < ActiveRecord::Migration
  def up
    create_table :stories do |t|
      t.integer :story_type
      t.date :posted_at
      t.boolean :is_public, default: false

      t.timestamps null: false
    end

    add_attachment :stories, :thumbnail

    Story.create_translation_table! :title => :string, :description => :text, :organization => :string,
                                    :url => :string, :embed_code => :text,
                                    image_file_name: :string,
                                    image_content_type: :string

    add_column :story_translations, :image_file_size, :integer
    add_column :story_translations, :image_updated_at, :datetime
    

    add_index :story_translations, :title
    add_index :stories, :story_type
    add_index :stories, :is_public 
    add_index :stories, :posted_at

  end

  def down
    drop_table :stories
    Story.drop_translation_table!
  end
end
