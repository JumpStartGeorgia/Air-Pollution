# == Schema Information
#
# Table name: stories
#
#  id                        :integer          not null, primary key
#  story_type                :integer
#  posted_at                 :datetime
#  is_public                 :boolean          default(FALSE)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  slug                      :string(255)
#  impressions_count         :integer          default(0)
#  image_en_file_name        :string(255)
#  image_en_content_type     :string(255)
#  image_en_file_size        :integer
#  image_en_updated_at       :datetime
#  image_ka_file_name        :string(255)
#  image_ka_content_type     :string(255)
#  image_ka_file_size        :integer
#  image_ka_updated_at       :datetime
#  thumbnail_en_file_name    :string(255)
#  thumbnail_en_content_type :string(255)
#  thumbnail_en_file_size    :integer
#  thumbnail_en_updated_at   :datetime
#  thumbnail_ka_file_name    :string(255)
#  thumbnail_ka_content_type :string(255)
#  thumbnail_ka_file_size    :integer
#  thumbnail_ka_updated_at   :datetime
#

class Story < ActiveRecord::Base

  ###########################
  ## CONSTANTS
  TYPE={infographic: 1, storybuilder: 2, radio: 3, animation: 4, video: 5, fact: 6, gif: 7}
  

  ###########################
  ## PAGE VIEW COUNTS
  is_impressionable :counter_cache => true, :unique => :session_hash

  ###########################
  ## TRANSLATIONS
  translates :title, :description, :organization,
              :url, :embed_code, 
              :slug,
              :fallbacks_for_empty_translations => true
  globalize_accessors

  ###########################
  ## URL SLUG
  extend FriendlyId
  friendly_id :title, :use => [:globalize, :history]

# for locale sensitive transliteration with friendly_id
  def normalize_friendly_id(input)
    input.to_s.to_url
  end

  ###########################
  ## RELATIONSHIPS
  has_many :datasources, :dependent => :destroy
  accepts_nested_attributes_for :datasources, :reject_if => lambda { |x| x[:name_en].blank? && x[:name_ka].blank? }, :allow_destroy => true


  ###########################
  ## THUMBNAIL PROCESSING
  has_attached_file :thumbnail_en,
                    :url => "/system/stories/:id/thumbnail/en/:style.:extension",
                    :default_url => "/images/missing/story/thumbnail/:style.png",
                    :styles => {
                        :'share' => {:geometry => "1200x>"},
                        :'xl' => '',
                        :'big' => '',
                        :'small' => ''
                    },
                    :convert_options => {
                      :'share' => '-quality 85',
                      :'xl' => '-quality 85 -thumbnail 1000x715^ -extent 1000x715',
                      :'big' => '-quality 85 -thumbnail 459x328^ -extent 459x328',
                      :'small' => '-quality 85 -thumbnail 229x164^ -extent 229x164'
                    }
  
  has_attached_file :thumbnail_ka,
                    :url => "/system/stories/:id/thumbnail/ka/:style.:extension",
                    :default_url => "/images/missing/story/thumbnail/:style.png",
                    :styles => {
                        :'share' => {:geometry => "1200x>"},
                        :'xl' => '',
                        :'big' => '',
                        :'small' => ''
                    },
                    :convert_options => {
                      :'share' => '-quality 85',
                      :'xl' => '-quality 85 -thumbnail 1000x715^ -extent 1000x715',
                      :'big' => '-quality 85 -thumbnail 459x328^ -extent 459x328',
                      :'small' => '-quality 85 -thumbnail 229x164^ -extent 229x164'
                    }
  
  has_attached_file :image_en,
                    :url => "/system/stories/:id/image/en/:style.:extension",
                    :default_url => "/images/missing/story/image/:style.png",
                    :styles => proc { |attachment| attachment.instance.attachment_styles }

  has_attached_file :image_ka,
                    :url => "/system/stories/:id/image/ka/:style.:extension",
                    :default_url => "/images/missing/story/image/:style.png",
                    :styles => proc { |attachment| attachment.instance.attachment_styles }

  # if this is a new record, do not apply the cropping processor
  # - the user must be able to set the crop size first
  def attachment_styles
    # if this is a gifographic, the thumbs must not be animated, but the rest must be
    if is_gif?
      {
        :'xl' => {:geometry => "1000x>", animated: false},
        :'big' => {:geometry => "600x>", animated: false},
        :'small' => {:geometry => "450>", animated: false}
      }
    else
      {
        :'xl' => {
          :geometry => "1000x>", 
          :convert_options => '-quality 85'
        },
        :'big' => {
          :geometry => "600x>", 
          :convert_options => '-quality 85'
        },
        :'small' => {
          :geometry => "450>", 
          :convert_options => '-quality 85'
        }
      }
    end
  end


  ###########################
  ## SEARCH
  scoped_search relation: :translations, on: [:title, :description, :organization]


  ###########################
  ## VALIDATIONS
  validates :story_type, :title, presence: true
  validates :story_type, inclusion: {in: TYPE.values}
  validates :url, :format => {:with => URI::regexp(['http','https'])}, :if => "!url.blank?"
  validates_attachment :thumbnail_en,
    content_type: { content_type: ["image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..5.megabytes }
  validates_attachment :thumbnail_ka,
    content_type: { content_type: ["image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..5.megabytes }
  validates_attachment :image_en,
    content_type: { content_type: ["image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..5.megabytes }
  validates_attachment :image_ka,
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
  ## CALLBACKS
  before_save :set_posted_at

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


  def image(locale=I18n.locale)
    locale = locale.to_sym
    locale = I18n.locale if !I18n.available_locales.include?(locale)

    return locale == :en ? image_en : image_ka
  end

  def thumbnail(locale=I18n.locale)
    locale = locale.to_sym
    locale = I18n.locale if !I18n.available_locales.include?(locale)

    return locale == :en ? thumbnail_en : thumbnail_ka
  end



  private

  # if this record is becoming public, set posted_at
  # if this record is being hidden from public, reset posted_at
  def set_posted_at
    if self.is_public? && self.is_public_changed?
      # becoming public
      self.posted_at = Time.now

    elsif !self.is_public? && self.is_public_changed?
      # loosing public
      self.posted_at = nil

    end

    return true
  end



end
