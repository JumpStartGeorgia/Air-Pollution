class Highlight < ActiveRecord::Base

  ###########################
  ## IMAGE PROCESSING
  ## this is in the translation
  has_attached_file :image,
                    :url => "/system/highlights/:id/:locale/:style.:extension",
                    :styles => {
                        :'big' => {:geometry => "2000x>"},
                        :'medium' => {:geometry => "1000x>"},
                        :'small' => {:geometry => "250x>"}
                    },
                    :convert_options => {
                      :'big' => '-quality 85',
                      :'medium' => '-quality 85',
                      :'small' => '-quality 85'
                    }

  ###########################
  ## TRANSLATIONS
  translates :title, :url,
              :image_file_name,
              :image_file_size,
              :image_content_type,
              :image_updated_at,
              :fallbacks_for_empty_translations => true
  globalize_accessors

  ###########################
  ## VALIDATIONS
  validates :title, :url, :image, presence: true
  validates :url, :format => {:with => URI::regexp(['http','https'])}, :if => "!url.blank?"
  validates_attachment :image,
    content_type: { content_type: ["image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..5.megabytes }

  ###########################
  ## SCOPES
  scope :published, -> {where(is_public: true)}
  scope :sorted, -> {with_translations(I18n.locale).order(posted_at: :desc, title: :asc)}

end
