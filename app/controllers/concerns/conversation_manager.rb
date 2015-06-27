module ConversationManager
  extend ActiveSupport::Concern

  # kind can be ":user_bang, :group_bang, :user_group"
  def create_conversation(user_ids, kind)
    conversation = Conversation.create!(kind: kind)
    for user_id in user_ids do
      ConversationUser.create!(
        conversation_id: conversation.id,
        user_id: user_id
      )
    end
    return conversation
  end
end
