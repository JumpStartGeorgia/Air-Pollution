# == Schema Information
#
# Table name: pledge_users
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  pledge_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PledgeUser < ActiveRecord::Base

  ###########################
  ## RELATIONSHIPS
  belongs_to :pledge
  belongs_to :user

  ###########################
  ## VALIDATIONS
  validates :pledge_id, :user_id, presence: true


end
