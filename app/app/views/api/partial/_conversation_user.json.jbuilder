json.extract! conversation_user, *[:id, :conversation_id, :user_id, :created_at, :updated_at]
json.user do
  json.partial! 'api/partial/user', user: conversation_user.user
end
