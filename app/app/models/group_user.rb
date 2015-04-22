# == Schema Information
#
# Table name: group_users
#
#  id         :integer          not null, primary key
#  group_id   :integer          not null
#  user_id    :integer          not null
#  status     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GroupUser < ActiveRecord::Base

	enum status: {inactive: 0, active: 1}
	
	belongs_to :group, class_name: 'Group', foreign_key: 'group_id'

	validates :group_id,
            presence: true,
            on: :create

    validates :user_id,
            presence: true,
            on: :create

	def status_value
      self.statuses[status]
    end

    def active?
      status == self.statuses[:active]
    end

end
