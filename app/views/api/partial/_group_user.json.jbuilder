json.extract! group_user, *[:id, :group_id, :user_id, :status, :created_at, :updated_at]
json.status group_user.status_value
