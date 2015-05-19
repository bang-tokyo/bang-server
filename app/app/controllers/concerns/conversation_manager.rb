module ConversationManager
  extend ActiveSupport::Concern

  # kind can be ":user_bang, :group_bang, :user_group"
  def create_conversation(users, kind)
    conversation = Conversation.create!(kind: kind)
    for user_id in users do
      ConversationUser.create!(
        conversation_id: conversation.id,
        user_id: user_id
      )
    end
    return conversation
  end
end
