class Api::V1::UsersController < Api::ApplicationController
  skip_before_action :authenticate, only: [:create]

  validates :show do
    integer :id, required: true
  end

  def create
    user = User.find_by(facebook_id: permitted_params[:facebook_id])
    if user.present?
      @user = user
      @is_new = false
    else
      @user = User.create!(permitted_params)
      @is_new = true
    end
    update_device(@user)
  end

  def show
    @user = User.find_by(id: params[:id])
    unless @user.present?
      render_not_found
      return
    end
  end

  def search
    exclusion_user_ids = UserBang.where(from_user_id: current_user.id).map { |user_bang|
      user_bang.user_id
    }
    exclusion_user_ids.push(current_user.id)
    # TODO : 位置情報などの要素で絞込み(リスティングロジック)の実装
    @users = User.where.not(id: exclusion_user_ids).limit(50)
  end

  private
  def permitted_params
    params.require(:user).permit(:facebook_id, :name, :birthday, :gender)
  end

  def update_device(user)
    h = custom_header
    Device.find_or_create_by(user_id: user.id, os: h.os, uuid: h.uuid, app_id: h.app_id).tap do |d|
      d.fill_from_header(h)
      d.status = :active
      d.save
    end
  end
end
