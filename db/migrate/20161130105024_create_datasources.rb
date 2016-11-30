class CreateDatasources < ActiveRecord::Migration
  def up
    create_table :datasources do |t|
      t.integer :story_id

      t.timestamps null: false
    end
    add_index :datasources, :story_id

    Datasource.create_translation_table! :name => :string, :url => :string
  end

  def down
    drop_table :datasources
    Datasource.drop_translation_table!
  end
end
