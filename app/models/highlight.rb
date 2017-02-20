# == Schema Information
#
# Table name: highlights
#
#  id                    :integer          not null, primary key
#  is_public             :boolean          default(FALSE)
#  posted_at             :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  image_en_file_name    :string(255)
#  image_en_content_type :string(255)
#  image_en_file_size    :integer
#  image_en_updated_at   :datetime
#  image_ka_file_name    :string(255)
#  image_ka_content_type :string(255)
#  image_ka_file_size    :integer
#  image_ka_updated_at   :datetime
#

class Highlight < ActiveRecord::Base

  ###########################
  ## TRANSLATIONS
  translates :title, :url, :fallbacks_for_empty_translations => true
  globalize_accessors

  ###########################
  ## IMAGE PROCESSING
  ## this is in the translation
  has_attached_file :image_en,
                    :url => "/system/highlights/:id/en/:style.:extension",
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

  has_attached_file :image_ka,
                    :url => "/system/highlights/:id/ka/:style.:extension",
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
  ## VALIDATIONS
  validates :title, :url, :image_en, :image_ka, presence: true
  validates :url, :format => {:with => URI::regexp(['http','https'])}, :if => "!url.blank?"
  validates_attachment :image_en,
    content_type: { content_type: ["image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..5.megabytes }
  validates_attachment :image_ka,
    content_type: { content_type: ["image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..5.megabytes }

  ###########################
  ## CALLBACKS
  before_save :set_posted_at

  ###########################
  ## SCOPES
  scope :published, -> {where(is_public: true)}
  scope :sorted, -> {with_translations(I18n.locale).order(posted_at: :desc, title: :asc)}

  #######################
  ## METHODS

  def image(locale=I18n.locale)
    locale = locale.to_sym
    locale = I18n.locale if !I18n.available_locales.include?(locale)

    return locale == :en ? image_en : image_ka
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
