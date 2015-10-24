class Api::V1::GroupsController < Api::ApplicationController

  validates :create do
    string :name, required: true
    string :user_ids
    string :memo
    integer :region_id, required: true
  end

  validates :update do
    integer :id, required: true
    string :name
    string :memo
    integer :region_id
  end

  validates :show do
    integer :id, required: true
  end

  validates :search do
    integer :limit
    integer :offset
  end

  def create

    owner_user_id = current_user.id
    name = params[:name]
    region_id = params[:region_id]
    memo = params[:memo]

    #ユーザーのチェック
    @user = User.find_by!(id: owner_user_id)
    raise Bang::Error::ValidationError.new unless @user.present?

    #グループ作成
    @group = Group.create!(
      name: name,
      memo: memo,
      region_id: region_id
    )
    
    #グループユーザー作成（オーナー）
    group_user = GroupUser.create!(
      owner_flg: 1,
      group_id: @group.id,
      user_id: owner_user_id,
      status: 1
    )
    @group.group_users.push(group_user)

    #グループ設定作成
    @group.group_setting = GroupSetting.create!(group_id: @group.id)

 end

 def update

    @group = Group.find_by!(id: params[:id])
    raise Bang::Error::ValidationError.new unless @group.present?

    @group = group.tap do |g|
      g.name = params[:name] if params[:name].present?
      g.memo = params[:memo] if params[:memo].present?
      g.region_id = params[:region_id] if params[:region_id].present?
    end

    @group.save!
  end

  def show
    @group = Group.find_by(id: params[:id])
    unless @group.present?
      render_not_found
      return
    end
    @groups = [@group]
  end

  def my
    user_id = current_user.id
    groups = Group.all
    #自分が所属するグループ(オーナーもしくはメンバー)
    @groups = groups.select do |group|
      group.group_users.map { |group_user|
        group_user.user_id
      }.include?(user_id)
    end
  end

  def search
    limit = params[:limit] || 20
    offset = params[:offset] || 0

    user_id = current_user.id
    groups = Group.all
    #自分が所属しているグループids
    exclusion_group_ids = groups.select { |group|
       group.group_users.map { |group_user|
         group_user.user_id
       }.include?(user_id) 
    }.map{ |group| group.id }
    
    #自分の所属するグループが既にbang済みの場合は除く
    exclusion_group_ids.push(
      GroupBang.where(from_group_id: exclusion_group_ids).map { |gb|
        gb.group_id
      })
    @groups = groups.where.not(id: exclusion_group_ids.uniq).limit(limit).offset(offset)
  end

  def destroy
    #物理削除にするか検討
  end

  # private
  # def permitted_params
  #   params.require(:group).permit(:owner_user_id, :name, :memo, :region_id)
  # end
end
