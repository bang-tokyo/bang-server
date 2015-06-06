class Api::V1::BangController < Api::ApplicationController
  include ConversationManager

  validates :request_bang do
    integer :id, required: true
  end

  validates :reply_bang do
    integer :id, required: true
    string :status, only: ['accept', 'deny'], required: true
  end

  # id = user_id (target's user_id)
  def request_bang
    user_id = params[:id]
    raise Bang::Error::InvalidUserBang if UserBang.conbination(user_id, current_user.id).present?
    raise Bang::Error::InvalidUserBang if UserBang.conbination(current_user.id, user_id).present?

    UserBang.create!(
      user_id: user_id,
      from_user_id: current_user.id
    )
  end

  # id = user_bang_id
  # status = accept or deny
  def reply_bang
    user_bang = UserBang.find_by(id: params[:id])
    raise Bang::Error::InvalidUserBang\
      if !user_bang.present?\
      || user_bang.user_id != current_user.id\
      || user_bang.has_replied?

    user_bang.status = UserBang.status_from_string(params[:status])
    if user_bang.accept?
      create_conversation [user_bang.user_id, user_bang.from_user_id], :user_bang
    end
    user_bang.save!
  end

  def request_list
    @user_bangs = UserBang.request_list(current_user.id)
  end
end
