class Api::V1::GroupsController < Api::ApplicationController

  def create
    @group = Group.create!(permitted_params)
    @group.save!
  end

  def show
    @group = Group.find_by(id: params[:id])
    unless @group.present?
      render_not_found
      return
    end
  end

  private
  def permitted_params
    #params.require(:user).permit(:facebook_id, :name, :birthday, :gender)
  end
end
