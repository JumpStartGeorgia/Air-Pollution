class MoveFileFields < ActiveRecord::Migration
  def self.up
    change_table :highlights do |t|
      t.attachment :image_en
      t.attachment :image_ka
    end
    change_table :stories do |t|
      t.attachment :image_en
      t.attachment :image_ka
    end

    remove_attachment :highlight_translations, :image
    remove_attachment :story_translations, :image
  end

  def self.down
    change_table :highlight_translations do |t|
      t.attachment :image
    end
    change_table :story_translations do |t|
      t.attachment :image
    end

    remove_attachment :highlights, :image_en
    remove_attachment :highlights, :image_ka

    remove_attachment :stories, :image_en
    remove_attachment :stories, :image_ka
  end
end
