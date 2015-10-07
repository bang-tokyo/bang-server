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
    @group_setting = GroupSetting.find_by!(group_id: group_id)

    @group_setting = @group_setting.tap do |setting|
      setting.key = params[:key]
      setting.value = params[:value]
    end

    @group_setting.save!

  end

  def show
    @group_setting = GroupSetting.find_by(group_id: params[:group_id])
    unless @group_setting.present?
      render_not_found
      return
    end
  end

end
