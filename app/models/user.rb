# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  role_id                :integer
#  provider               :string(255)
#  uid                    :string(255)
#  nickname               :string(255)
#  avatar                 :string(255)
#

# Contains account data
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable, 
         :omniauthable, :omniauth_providers => [:facebook]

  belongs_to :role
  # Email already required by devise
  validates :role, presence: true

  before_validation :check_role
  def check_role
    self.role_id = 1 if self.role_id.nil?
  end

  # requested_role may be the name of one role (a string)
  # or an array of possible roles
  def is?(requested_role)
    self.role_id && ((requested_role.is_a?(String) && role.name == requested_role) || (requested_role.is_a?(Array) && requested_role.include?(self.role.name)))
  end

  def manageable_roles
    Role.all.select { |role| Ability.new(self).can? :manage, role }
  end


  ####################################
  ## OMNIAUTH LOGIN
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email.present? ? auth.info.email : "#{Devise.friendly_token[0,10]}@fake.com"
      user.password = Devise.friendly_token[0,20]
      user.nickname = auth.info.nickname,
      user.avatar = auth.info.image
      user.role_id = 1 #user
    end
  end

  # if login fails with omniauth, sessions values are populated with
  # any data that is returned from omniauth
  # this helps load them into the new user registration url
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
