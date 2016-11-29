# == Schema Information
#
# Table name: stories
#
#  id                     :integer          not null, primary key
#  story_type             :integer
#  posted_at              :date
#  is_public              :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  thumbnail_file_name    :string(255)
#  thumbnail_content_type :string(255)
#  thumbnail_file_size    :integer
#  thumbnail_updated_at   :datetime
#

class Story < ActiveRecord::Base

  ###########################
  ## CONSTANTS
  TYPE={infographic: 1, storybuilder: 2, radio: 3, animation: 4, video: 5, fact: 6, gif: 7}
  paginates_per 4

  ###########################
  ## IMAGE PROCESSING
  ## this is in the translation
  has_attached_file :image,
                    :url => "/system/stories/:id/image/:locale/:style.:extension",
                    :styles => {
                        :'big' => {:geometry => "650x400#"},
                        :'small' => {:geometry => "130x80#"}
                    },
                    :convert_options => {
                      :'big' => '-quality 85',
                      :'small' => '-quality 85'
                    }

  ###########################
  ## TRANSLATIONS
  translates :title, :description, :organization,
              :url, :embed_code,
              :image_file_name,
              :image_file_size,
              :image_content_type,
              :image_updated_at, :fallbacks_for_empty_translations => true
  globalize_accessors

  ###########################
  ## THUMBNAIL PROCESSING
  has_attached_file :thumbnail,
                    :url => "/system/stories/:id/thumbnail/:style.:extension",
                    :styles => {
                        :'big' => {:geometry => "459x328#"},
                        :'small' => {:geometry => "229x164#"}
                    },
                    :convert_options => {
                      :'big' => '-quality 85',
                      :'small' => '-quality 85'
                    }
  

  ###########################
  ## VALIDATIONS
  validates :story_type, :title, :url, :posted_at, presence: true
  validates :story_type, inclusion: {in: TYPE.values}
  validates_attachment :thumbnail,
    content_type: { content_type: ["image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..5.megabytes }
  validates_attachment :image,
    content_type: { content_type: ["image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..5.megabytes }
  validate :story_type_data

  # check the story type and make sure the corresponding fields are provided
  # - infographic, gif, fact -> image
  # - all else, embed code
  def story_type_data
    if (self.needs_image?) && self.image.nil?
      errors.add(:image, "is required")
    elsif self.needs_embed? && self.embed_code.nil?
      errors.add(:enbed_code, "is required")
    end
  end

  ###########################
  ## SCOPES
  # only get the pledges that 
  scope :published, -> {where(is_public: true)}
  scope :sorted, -> {with_translations(I18n.locale).order(posted_at: :desc, title: :asc)}
  def self.by_type(story_type)
    where(story_type: story_type)
  end


  ###########################
  ## METHODS
  def is_infographic?
    self.story_type == TYPE[:infographic]
  end

  def is_gif?
    self.story_type == TYPE[:gif]
  end

  def is_fact?
    self.story_type == TYPE[:fact]
  end

  def is_storybuilder?
    self.story_type == TYPE[:storybuilder]
  end

  def is_radio?
    self.story_type == TYPE[:radio]
  end

  def is_animation?
    self.story_type == TYPE[:animation]
  end

  def is_video?
    self.story_type == TYPE[:video]
  end

  def needs_image?
    self.is_infographic? || self.is_fact? || self.is_gif?
  end
  def needs_embed?
    self.is_storybuilder? || self.is_radio? || self.is_animation? || self.is_video?
  end

end
