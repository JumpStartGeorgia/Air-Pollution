class StoryThumbnailI18n < ActiveRecord::Migration
  def self.up
    change_table :stories do |t|
      t.attachment :thumbnail_en
      t.attachment :thumbnail_ka
    end

    remove_attachment :stories, :thumbnail
  end

  def self.down
    change_table :stories do |t|
      t.attachment :thumbnail
    end

    remove_attachment :stories, :thumbnail_en
    remove_attachment :stories, :thumbnail_ka
  end
end
