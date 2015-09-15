json.extract! group, *[:id, :owner_user_id, :name, :memo, :region_id, :status, :created_at, :updated_at]
json.status group.status_value
json.group_users do
  json.array! group.group_users do |group_user|
    json.partial! 'api/partial/group_user', group_user: group_user
  end
end
