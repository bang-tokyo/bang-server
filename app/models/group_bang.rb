# == Schema Information
#
# Table name: group_bangs
#
#  id            :integer          not null, primary key
#  group_id      :integer          not null
#  from_group_id :integer          not null
#  item_id       :integer          default(0), not null
#  status        :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class GroupBang < ActiveRecord::Base
  enum status: {default: 0, accept: 1, deny: 2}

  belongs_to :from_group, class_name: 'Group', foreign_key: 'from_group_id'

  scope :conbination, -> (group_id, from_group_id) {
    where('group_id = ? and from_group_id = ?', group_id, from_group_id)
  }

  scope :request_list, -> (group_id) {
    where('group_id = ? and status = 0', group_id)
  }

  class << self
    def status_from_string(string)
      case string.downcase
      when 'accept' then :accept
      when 'deny' then :deny
      else :default
      end
    end
  end

  def has_replied?
    accept? || deny?
  end

  def accept?
    status_value == self.class.statuses[:accept]
  end

  def deny?
    status_value == self.class.statuses[:deny]
  end

  def status_value
    self.class.statuses[status]
  end
end
