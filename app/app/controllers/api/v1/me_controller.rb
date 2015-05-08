class Api::V1::MeController < Api::ApplicationController
  def show
    @user = current_user
  end

  def update
    update_user
    @user = current_user
  end

  private

  def update_user
    user = current_user.tap do |u|
      u.gender = User.gender_from_string(params[:gender]) if params[:gender].present?
      u.name = params[:name] if params[:name].present?
    end
    update_user_attribute('self_introduction')
  end

  def update_user_attribute(key)
    if params[key].present?
      value = params[key]
      user_attribute = current_user.user_attributes.by_key(key).first
      if user_attribute.present?
        user_attribute.value = value
        user_attribute.save!
      else
        user_attribute = UserAttribute.create!(
          user_id: current_user.id,
          key: key,
          value: value
        )
      end
    end
  end
end
