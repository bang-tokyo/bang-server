json.extract! user, *[:id, :facebook_id, :name, :birthday, :created_at, :updated_at]
json.gender user.gender_value
json.status user.status_value
