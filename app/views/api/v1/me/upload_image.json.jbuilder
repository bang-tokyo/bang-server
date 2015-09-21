if @user_profile_image.present?
  json.image_path @user_profile_image.image_path
  json.id @user_profile_image.id
end
