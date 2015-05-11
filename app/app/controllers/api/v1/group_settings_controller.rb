class Api::V1::GroupSettingsController < Api::ApplicationController

  validates :update do
    integer :group_id, required: true
    integer :key, required: true
    integer :value, required: true
  end

  validates :show do
    integer :group_id, required: true
  end

  def update

    group_id = params[:group_id]

    @group = Group.find_by!(id: group_id)
    group_setting = GroupSetting.find_or_create_by(group_id: group_id) do |s|
      s.key = params[:key]
      s.value = params[:value]
    end

    group_setting.group = @group
    group_setting.save

  end

  def show
    @group_setting = GroupSetting.find_by(id: params[:group_id])
    unless @group_setting.present?
      render_not_found
      return
    end
  end

end
