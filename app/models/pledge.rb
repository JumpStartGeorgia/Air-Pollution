# == Schema Information
#
# Table name: pledges
#
#  id                 :integer          not null, primary key
#  posted_at          :date
#  is_public          :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Pledge < ActiveRecord::Base
  ###########################
  ## PAGE VIEW COUNTS
  is_impressionable :counter_cache => true, :unique => :session_hash

  ###########################
  ## TRANSLATIONS
  translates :title, :why_care, :what_it_is, :what_you_do, :slug,
              :fallbacks_for_empty_translations => true
  globalize_accessors

  ###########################
  ## URL SLUG
  extend FriendlyId
  friendly_id :title, :use => [:globalize, :history]

  ###########################
  ## IMAGE PROCESSING
  has_attached_file :image,
                    :url => "/system/pledges/:id/:style.:extension",
                    :default_url => "/assets/missing/pledge/image/:style.png",
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
  validates :title, :posted_at, presence: true
  validates_attachment :image,
    content_type: { content_type: ["image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..5.megabytes }

  ###########################
  ## SCOPES
  scope :published, -> {where(is_public: true)}
  scope :sorted, -> {with_translations(I18n.locale).order(posted_at: :desc, title: :asc)}
  def self.latest
    published.sorted.first
  end
  def self.except_pledge(id)
    where.not(id: id)
  end

end
