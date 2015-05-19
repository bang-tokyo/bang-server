# == Schema Information
#
# Table name: conversation_users
#
#  id              :integer          not null, primary key
#  conversation_id :integer          not null
#  user_id         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ConversationUser < ActiveRecord::Base
  has_one :user
  belongs_to :conversation, class_name: 'Conversation', foreign_key: 'conversation_id'
end
