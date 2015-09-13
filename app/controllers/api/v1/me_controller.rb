class Api::V1::MeController < Api::ApplicationController

  validates :update do
    string :name
    string :gender
    string :self_introduction
    string :self_introduction_long
    integer :blood_type
    integer :region_id
    integer :profile_image_0
    integer :profile_image_1
    integer :profile_image_2
    integer :profile_image_3
    integer :profile_image_4
    integer :profile_image_5
  end

  validates :upload_image do
    integer :index, required: true
    file :image
  end

  validates :update_location do
    float :latitude, required: true
    float :longitude, required: true
  end

  def show
    @user = current_user
  end

  def update
    update_user
    @user = current_user
  end

  def upload_image
    user = current_user
    @user_profile_image = upload_user_profile_image(user, params[:index], params[:image]) if params[:image].present?
  end

  def update_location
    update_user_location
  end

  private

  def update_user
    # modify user
    user = current_user.tap do |u|
      u.gender = User.gender_from_string(params[:gender]) if params[:gender].present?
      u.name = params[:name] if params[:name].present?
      u.blood_type = params[:blood_type] if params[:blood_type].present?
      u.region_id = params[:region_id] if params[:region_id].present?
    end
    user.save

    # modify user attribute
    update_user_attribute('self_introduction')
    update_user_attribute('self_introduction_long')
    for i in 0..5 do
      update_user_attribute("profile_image_#{i}")
    end
  end

  def update_user_attribute(key)
    if params[key].present?
      update_user_attribute_with_value(key, params[key])
    end
  end

  def update_user_attribute_with_value(key, value)
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

  def upload_user_profile_image(user, index, image)
    profile_image_id = user.profile_image_id_by(index)  
    user_profile_image = profile_image_id != 0 ?
      UserProfileImage.find_or_create_by(id: profile_image_id) do |upi| upi.user_id = user.id end :
      UserProfileImage.create!(user_id: user.id)
    user_profile_image.touch

    Bang::ProfileImageUploader.upload_image_to_s3(image, user_profile_image)

    update_user_attribute_with_value("profile_image_#{index}", user_profile_image.id)
    return user_profile_image
  end

  def update_user_location
      user_location = UserLocation.find_by(user_id: current_user.id)
      if user_location.present?
        user_location.latitude = params[:latitude]
        user_location.longitude = params[:longitude]
        user_location.save!
      else
        UserLocation.create!(
          user_id: current_user.id,
          latitude: params[:latitude],
          longitude: params[:longitude]
        )
      end
  end
end
