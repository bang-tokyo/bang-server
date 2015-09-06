# == Schema Information
#
# Table name: user_attributes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  key        :string(50)       default(""), not null
#  value      :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserAttribute < ActiveRecord::Base
  ACCEPTABLE_KEYS = [
    'self_introduction',
    'self_introduction_long',
    'profile_image_0',
    'profile_image_1',
    'profile_image_2',
    'profile_image_3',
    'profile_image_4',
    'profile_image_5'
  ]

  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

  scope :by_key, -> (key) { where(key: key) }

  before_validation :check_key, on: :create

  private
  def check_key
    return ACCEPTABLE_KEYS.any? {|key| key == self.key}
  end
end
