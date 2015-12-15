json.extract! group_user, *[:id, :group_id, :user_id, :owner_flg, :status, :created_at, :updated_at]
json.status group_user.status_value
json.facebook_id group_user.user.facebook_id
