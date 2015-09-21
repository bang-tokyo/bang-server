json.extract! user, *[:id, :facebook_id, :name, :birthday, :region_id, :created_at, :updated_at]
json.gender user.gender_value
json.status user.status_value
json.blood_type user.blood_type_value
json.region user.region_name
json.self_introduction user.self_introduction
json.self_introduction_long user.self_introduction_long
for i in 0..user.prifile_image_max_num
  json.set! :"profile_image_#{i}", user.profile_image_id_by(i)
  json.set! :"profile_image_path_#{i}", user.prifile_image_path_by(i)
end
