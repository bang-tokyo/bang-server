# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  conversation_id :integer          not null
#  user_id         :integer          not null
#  message         :string(191)      default(""), not null
#  status          :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Message < ActiveRecord::Base
  enum status: {active: 0, deleted: 1}

  belongs_to :conversation, class_name: 'Conversation', foreign_key: 'conversation_id'

  before_validation :check_message, on: :create

  def status_value
    self.class.statuses[status]
  end

  private
  def check_message
    # TODO : messageのvalidate
    return true
  end
end
