class Api::V1::GroupBangController < Api::ApplicationController
  include ConversationManager

  validates :request_bang do
    integer :group_id, required: true
    integer :from_group_id, required: true
  end

  validates :reply_bang do
    integer :group_id, required: true
    integer :from_group_id, required: true
    string :status, only: ['accept', 'deny'], required: true
  end

  def request_bang
    group_id = params[:group_id]
    from_group_id = params[:from_group_id]

    print group_id
    print from_group_id
    raise Bang::Error::InvalidGroupBang if GroupBang.conbination(group_id, from_group_id).present?

    GroupBang.create!(
      group_id: group_id,
      from_group_id: from_group_id
    )
  end

  def reply_bang
    group_id = params[:group_id]
    from_group_id = params[:from_group_id]
    status  = params[:status]
    group_bang = GroupBang.find_by(group_id: group_id)
    raise Bang::Error::InvalidGroupBang\
      if !group_bang.present?\
      || group_bang.group_id != from_group_id\
      || group_bang.has_replied?

    group_bang.status = GroupBang.status_from_string(status)
    if group_bang.accept?
      create_conversation [group_bang.group_id, group_bang.from_group_id], :group_bang
    end
    group_bang.save!
    @group_bang = group_bang
  end

  def request_list
    group_id = params[:group_id]
    @group_bangs = GroupBang.request_list(group_id)
  end
end
