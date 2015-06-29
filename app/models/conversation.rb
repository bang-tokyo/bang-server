# == Schema Information
#
# Table name: conversations
#
#  id         :integer          not null, primary key
#  kind       :integer          default(0), not null
#  status     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Conversation < ActiveRecord::Base
  enum kind: {user_bang: 0, group_bang: 1, user_group: 2}
  enum status: {active: 0, banned: 1}

  has_many :conversation_users
  has_many :messages

  class << self
    def kind_from_string(string)
      case string.downcase
      when 'user_group' then :user_group
      when 'group_bang' then :group_bang
      else :user_bang
      end
    end
  end

  def kind_value
    self.class.kinds[kind]
  end

  def status_value
    self.class.statuses[status]
  end

  def belonged_user_ids
    self.conversation_users.map{ |cu| cu.user_id }
  end
end
