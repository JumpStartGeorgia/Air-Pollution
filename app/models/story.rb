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
  

  ###########################
  ## PAGE VIEW COUNTS
  is_impressionable :counter_cache => true, :unique => :session_hash

  ###########################
  ## IMAGE PROCESSING
  ## this is in the translation
  has_attached_file :image,
                    :url => "/system/stories/:id/image/:locale/:style.:extension",
                    :default_url => "/assets/missing/story/image/:style.png",
                    :styles => {
                        :'xl' => {:geometry => "1000x>"},
                        :'big' => {:geometry => "600x>"},
                        :'small' => {:geometry => "450>"}
                    },
                    :convert_options => {
                      :'xl' => '-quality 85',
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
              :image_updated_at, 
              :slug,
              :fallbacks_for_empty_translations => true
  globalize_accessors

  ###########################
  ## URL SLUG
  extend FriendlyId
  friendly_id :title, :use => [:globalize, :history]

  ###########################
  ## RELATIONSHIPS
  has_many :datasources, :dependent => :destroy
  accepts_nested_attributes_for :datasources, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true


  ###########################
  ## THUMBNAIL PROCESSING
  has_attached_file :thumbnail,
                    :url => "/system/stories/:id/thumbnail/:style.:extension",
                    :default_url => "/assets/missing/story/thumbnail/:style.png",
                    :styles => {
                        :'xl' => {:geometry => "600x>"},
                        :'big' => {:geometry => "459x328#"},
                        :'small' => {:geometry => "229x164#"}
                    },
                    :convert_options => {
                      :'xl' => '-quality 85',
                      :'big' => '-quality 85',
                      :'small' => '-quality 85'
                    }
  

  ###########################
  ## SEARCH
  scoped_search relation: :translations, on: [:title, :description, :organization]


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
    if (self.has_image?) && self.image.nil?
      errors.add(:image, "is required")
    elsif self.has_embed? && self.embed_code.nil?
      errors.add(:enbed_code, "is required")
    end
  end

  ###########################
  ## SCOPES
  scope :published, -> {where(is_public: true)}
  scope :sort_recent, -> {with_translations(I18n.locale).order(posted_at: :desc, title: :asc)}
  scope :sort_views, -> {with_translations(I18n.locale).order(impressions_count: :desc, posted_at: :desc, title: :asc)}
  def self.by_type(story_type)
    where(story_type: story_type)
  end
  def self.with_datasources
    includes(datasources: :translations)
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

  def has_image?
    self.is_infographic? || self.is_fact? || self.is_gif?
  end
  def has_embed?
    self.is_storybuilder? || self.is_radio? || self.is_animation? || self.is_video?
  end


  def story_type_key
    if self.story_type.present?
      return TYPE.keys[TYPE.values.index(self.story_type.to_i)]
    end
  end

end
