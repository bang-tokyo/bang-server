class Api::V1::UsersController < Api::ApplicationController

  # TODO weak_parameters 導入した方がよさげ

  def create
    # TODO FacebookIDで一度UserをSelectあれば何もしないなければcreateする
    @user = User.create!(permitted_params)
    @user.save!
    @is_new = true
  end

  def show
    @user = User.find_by(id: params[:id])
    unless @user.present?
      render_not_found
      return
    end
  end

  private
  def permitted_params
    params.require(:user).permit(:facebook_id, :name, :birthday, :gender)
  end
end
