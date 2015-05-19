class Api::V1::BangController < ApplicationController
  include ConversationManager

  validates :request do
    integer :user_id, required: true
  end

  validates :request do
    integer :user_bang_id, required: true
    string :status, required: true
  end

  def request
    user_id = params[:user_id]
    raise Bang::Error::InvalidUserBang if UserBang.conbination(user_id, current_user.id).present?
    raise Bang::Error::InvalidUserBang if UserBang.conbination(current_user.id, user_id).present?

    UserBang.create!(
      user_id: user_id,
      from_user_id: current_user.id
    )
  end

  def reply
    user_bang = UserBang.find_by(params[:user_bang_id])
    raise Bang::Error::InvalidUserBang unless user_bang.present?
    raise Bang::Error::InvalidUserBang unless user_bang.user_id == current_user.id
    unless user_bang.replied?
      user_bang.status = UserBang.status_from_string(params[:status])
      user_bang.save!
      create_conversation [user_bang.user_id, user_bang.from_user_id], :user_bang
    end
  end
end
