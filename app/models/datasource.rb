# == Schema Information
#
# Table name: datasources
#
#  id         :integer          not null, primary key
#  story_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Datasource < ActiveRecord::Base
  ###########################
  ## TRANSLATIONS
  translates :name, :url
  globalize_accessors
  
  ###########################
  ## VALIDATIONS
  validates :name, :story_id, presence: true
  validates :url, :format => {:with => URI::regexp(['http','https'])}, :if => "!url.blank?"

  ###########################
  ## SCOPES
  def self.sorted(locale=I18n.locale)
    with_translations(locale).order(:name)
  end

end
