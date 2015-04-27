class Api::V1::GroupUsersController < Api::ApplicationController

  validates :create do
    integer :group_id, required: true
    integer :user_id, required: true
  end

  validates :index do
    integer :group_id, required: true
    integer :limit
    integer :offset
  end

  def create

    group_id = params[:group_id]
    user_id = params[:user_id]

    #ユーザーのチェック
    user = User.find_by(id: user_id)
    raise Bang::Error::ValidationError.new unless user.present?

    #グループ作成
    @group_user = GroupUser.create!(
      group_id: group_id
      user_id: user_id
    )

  end

  def index
    group_id = params[:group_id]
    limit = params[:limit] || 20
    offset = params[:offset] || nil

    @group_user = GroupUser.where(group_id: group_id).limit(limit).order('id desc').offset(offset)
  end

  def destroy
    #物理削除にするか検討
  end

end
