class Api::V1::MessagesController < Api::ApplicationController

  validates :create do
    integer :conversation_id, required: true
    string :message, required: true
  end

  def create
    @conversation = Conversation.find_by(id: params[:conversation_id])
    raise Bang::Error::ConversationNotFound unless @conversation.present?
    raise Bang::Error::ConversationUserNotFound\
      unless @conversation.conversation_users.find_by(user_id: current_user.id).present?

    @message = Message.create!(
      conversation_id: @conversation.id,
      user_id: current_user.id,
      message: params[:message]
    )
    @conversation.touch
    @conversation.save
  end
end
