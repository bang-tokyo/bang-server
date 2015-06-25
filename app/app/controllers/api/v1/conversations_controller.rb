class Api::V1::ConversationsController < Api::ApplicationController

  validates :index do
    integer :count
  end

  validates :show do
    integer :id, required: true
    integer :count
  end

  validates :destroy do
    integer :id, required: true
  end

  def index
    count = params[:count] || 20

    conversation_ids = ConversationUser.where(user_id: current_user.id).map { |conversation_user|
      conversation_user.conversation_id
    }
    @conversations = conversation_ids.present?\
      ? Conversation.where(id: conversation_ids).order('updated_at desc').limit(count)\
      : []
  end

  def show
    @conversation = Conversation.find_by(id: params[:id])
    raise Bang::Error::ConversationNotFound unless @conversation.present?
    raise Bang::Error::ConversationUserNotFound\
      unless @conversation.conversation_users.find_by(user_id: current_user.id).present?
  end

  def destroy
  end
end
