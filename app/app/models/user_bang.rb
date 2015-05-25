# == Schema Information
#
# Table name: user_bangs
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  from_user_id :integer          not null
#  item_id      :integer          default(0), not null
#  status       :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class UserBang < ActiveRecord::Base
  enum status: {default: 0, accept: 1, deny: 2}

  scope :conbination, -> (user_id, from_user_id) {
    where('user_id = ? and from_user_id = ?', user_id, from_user_id)
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
