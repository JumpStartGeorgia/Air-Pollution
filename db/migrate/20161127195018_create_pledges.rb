class CreatePledges < ActiveRecord::Migration
  def up
    create_table :pledges do |t|
      t.date :posted_at
      t.boolean :is_public, default: false

      t.timestamps null: false
    end

    add_attachment :pledges, :image

    Pledge.create_translation_table! :title => :string, :text => :text
    add_index :pledge_translations, :title
    add_index :pledges, :posted_at

  end

  def down
    drop_table :pledges
    Pledge.drop_translation_table!
  end
end
