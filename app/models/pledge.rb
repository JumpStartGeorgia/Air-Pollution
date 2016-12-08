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
#  impressions_count  :integer          default(0)
#  slug               :string(255)
#  pledge_count       :integer          default(0)
#

class Pledge < ActiveRecord::Base
  ###########################
  ## PAGE VIEW COUNTS
  is_impressionable :counter_cache => true, :unique => :session_hash

  ###########################
  ## TRANSLATIONS
  translates :title, :why_care, :what_it_is, :what_you_do, :slug, \
              :text, # text is no longer used but is needed here for migrations
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
                        :'share' => {:geometry => "1200x>"},
                        :'big' => {:geometry => "459x328#"},
                        :'small' => {:geometry => "229x164#"}
                    },
                    :convert_options => {
                      :'share' => '-quality 85',
                      :'big' => '-quality 85',
                      :'small' => '-quality 85'
                    }
  
  ###########################
  ## RELATIONSHIPS
  has_many :pledge_users, :dependent => :destroy
  accepts_nested_attributes_for :pledge_users, :reject_if => lambda { |a| a[:user_id].blank? }, :allow_destroy => true

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


  ###########################
  ## METHODS
  def make_pledge(user)
    self.pledge_count += 1
    self.pledge_users.build(user_id: user.id)
    self.save
  end

  def has_made_pledge?(user)
    self.pledge_users.where(user_id: user.id).count > 0
  end
end
