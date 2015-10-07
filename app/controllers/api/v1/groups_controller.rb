class Api::V1::GroupsController < Api::ApplicationController

  validates :create do
    integer :owner_user_id, required: true
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

    owner_user_id = params[:owner_user_id]
    name = params[:name]

    #ユーザーのチェック
    @user = User.find_by!(id: owner_user_id)
    raise Bang::Error::ValidationError.new unless @user.present?
    raise Bang::Error::ValidationError.new unless name.present?

    #グループ作成
    @group = Group.create!(
      owner_user_id: owner_user_id,
      name: name,
      memo: params[:memo],
      region_id: params[:region_id]
    )

    #グループ設定作成
    @group_setting = GroupSetting.create(group_id: @group.id)

    unless @group_setting.nil?
      @group.group_setting = @group_setting
    end

    #グループユーザー作成
    user_ids = params[:user_ids]

    #user_idsからuser modelを取得
    @users = User.where(id: user_ids)
    @users.each{|user|
      #グループユーザー作成
      @group_user = GroupUser.create!(
        group_id: group.id,
        user_id: user.id
      )
    }
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
    groups = Group.includes(:group_users)
    #自分が所属するグループ(オーナーもしくはメンバー)
    @groups = groups.select do |group|
      group.owner_user_id == user_id || group.group_users.map{|group_user| group_user.user_id}.include?(user_id)
    end
    
    @groups.each do |group|
      group.group_users.each do |group_user|
        group_user.user = User.find_by(id: group_user.user_id)
      end
    end
  end

  def search
    limit = params[:limit] || 20
    offset = params[:offset] || 0

    #group_scope = Group.where('owner_user_id = ?', current_user.id)
    #group_where = group_scope.arel.constraints.reduce(:and)
    #group_bind = group_scope.bind_values
    #group_user_scope = GroupUser.where(user_id: current_user.id)
    #group_user_where = group_user_scope.arel.constraints.reduce(:and)
    #group_user_bind = group_user_scope.bind_values
 
    #exclusion_group_ids = Group.eager_load(:group_users).where(group_where.or group_user_where).tap {|sc| sc.bind_values = group_bind + group_user_bind }.map { |g| g.id }

    ##自分の所属するグループが既にbang済みの場合は除く
    #exclusion_group_ids.push(GroupBang.where(from_group_id: exclusion_group_ids).map { |gb| gb.group_id })
    #@groups = Group.where.not(id: exclusion_group_ids.uniq).limit(limit) 

    #@groups.each do |group|
    #  group.group_users = GroupUser.find_by(group_id: group.id)
    #end
    user_id = current_user.id
    groups = Group.includes(:group_users)
    #自分が所属しているグループ
    exclusion_groups = groups.select do |group|
       group.owner_user_id == user_id || group.group_users.map{|group_user| group_user.user_id}.include?(user_id)
    end

    exclusion_group_ids = exclusion_groups.map { |g| g.id }
  
    #自分の所属するグループが既にbang済みの場合は除く
    exclusion_group_ids.push(GroupBang.where(from_group_id: exclusion_group_ids).map { |gb| gb.group_id })
    @groups = Group.where.not(id: exclusion_group_ids.uniq).limit(limit).offset(offset)

    @groups.each do |group|
       group.group_users.each do |group_user|
          group_user.user = User.find_by(id: group_user.user_id)
       end
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
