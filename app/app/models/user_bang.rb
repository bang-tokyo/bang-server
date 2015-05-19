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
  enum status: {default: 0, accepted: 1, denied: 2}

  scope :conbination, -> (user_id, from_user_id) {
    where('user_id = ? and from_user_id = ?', user_id, from_user_id)
  }

  class << self
    def status_from_string(string)
      case string.downcase
      when 'accept' then :accepted
      when 'deny' then :denied
      else :default
      end
    end
  end

  def replied?
    !accepted? && !denied?
  end

  def accepted?
    status_value == self.class.statuses[:accepted]
  end

  def denied?
    status_value == self.class.statuses[:denied]
  end

  def status_value
    self.class.statuses[status]
  end
end
