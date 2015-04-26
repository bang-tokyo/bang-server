class Api::V1::GroupsController < Api::ApplicationController

  def create

    owner_user_id = params[:owner_user_id]
    name = params[:name]

    #ユーザーのチェック
    user = User.find_by!(id: owner_user_id)
    raise Bang::Error::AuthenticationFailed.new unless user.present?
    raise Bang::Error::AuthenticationFailed.new unless name.present?

    #グループ作成
    @group = Group.create!(
      owner_user_id: owner_user_id,
      name: name,
      memo: params[:memo],
      region_id: params[:region_id]
    )

  end

  def update
    #verify_post_permission!

    group = Group.find_by!(id: params[:group_id])
    raise Bang::Error::AuthenticationFailed.new unless group.present?

    #verify_answer!(answer)

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
  end

  def destroy
    #物理削除にするか検討
  end

  # private
  # def permitted_params
  #   params.require(:group).permit(:owner_user_id, :name, :memo, :region_id)
  # end
end
