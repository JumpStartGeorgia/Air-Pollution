class Datasource < ActiveRecord::Base
  ###########################
  ## TRANSLATIONS
  translates :name, :url
  globalize_accessors
  
  ###########################
  ## VALIDATIONS
  validates :name, :url, :story_id, presence: true
  validates :url, :format => {:with => URI::regexp(['http','https'])}, :if => "!url.blank?"


end
