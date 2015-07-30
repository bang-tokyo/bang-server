# == Schema Information
#
# Table name: groups
#
#  id            :integer          not null, primary key
#  owner_user_id :integer          not null
#  name          :string(100)      default(""), not null
#  memo          :text(65535)
#  region_id     :integer          default(0), not null
#  status        :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Group < ActiveRecord::Base

  enum status: {inactive: 0, active: 1}

  has_many :group_users, class_name: 'GroupUser', dependent: :destroy
  has_one :group_setting, class_name: 'GroupSetting', dependent: :destroy

  validates :owner_user_id,
            presence: true,
            on: :create

  def status_value
    self.statuses[status]
  end

  def active?
    status == self.statuses[:active]
  end

end
