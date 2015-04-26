class Api::V1::UsersController < Api::ApplicationController
  skip_before_action :authenticate, only: [:create]

  # TODO weak_parameters 導入した方がよさげ

  def create
    user = User.find_by(facebook_id: permitted_params[:facebook_id])
    if user.present?
      @user = user
      @is_new = false
    else
      @user = User.create!(permitted_params)
      @user.save!
      @is_new = true
    end
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
