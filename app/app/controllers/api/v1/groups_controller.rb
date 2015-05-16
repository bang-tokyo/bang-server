class Api::V1::GroupsController < Api::ApplicationController

  validates :create do
    integer :owner_user_id, required: true
    string :name, required: true
    string :user_ids
    string :memo
    integer :region_id
  end

  validates :update do
    integer :group_id, required: true
    string :name
    string :memo
    integer :region_id
  end

  validates :show do
    integer :group_id, required: true
  end

  validates :index do
    integer :limit
    integer :offset
  end

  def create

    owner_user_id = params[:owner_user_id]
    name = params[:name]

    #ユーザーのチェック
    user = User.find_by!(id: owner_user_id)
    raise Bang::Error::ValidationError.new unless user.present?
    raise Bang::Error::ValidationError.new unless name.present?

    #グループ作成
    @group = Group.create!(
      owner_user_id: owner_user_id,
      name: name,
      memo: params[:memo],
      region_id: params[:region_id]
    )

    #グループユーザー作成
    user_ids = params[:user_ids]

    if user_ids.length > 0

      user_ids.each{|user_id|

        #ユーザーのチェック
        user = User.find_by!(id: user_id)
        raise Bang::Error::ValidationError.new unless user.present?

        #グループユーザー作成
        @group_user = GroupUser.create!(
          group_id: @group.id
          user_id: user_id
        )
      }

    end

  end

  def update

    group = Group.find_by!(id: params[:group_id])
    raise Bang::Error::ValidationError.new unless group.present?

    @group = group.tap do |g|
      g.name = params[:name] if params[:name].present?
      g.memo = params[:memo] if params[:memo].present?
      g.region_id = params[:region_id] if params[:region_id].present?
    end

    @group.save!
  end

  def show
    @group = Group.find_by(id: params[:group_id])
    unless group.present?
      render_not_found
      return
    end
  end

  def index
    limit = params[:limit] || 20
    offset = params[:offset] || nil

    @groups = Group.limit(limit).order('id desc').offset(offset)

    @groups.each do |group|
      group.users = GroupUser.where(group_id: group.id)
    end

  end

  def destroy
    #物理削除にするか検討
  end

  # private
  # def permitted_params
  #   params.require(:group).permit(:owner_user_id, :name, :memo, :region_id)
  # end
end
