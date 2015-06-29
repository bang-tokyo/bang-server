json.extract! conversation, *[:id, :created_at, :updated_at]
json.kind conversation.kind_value
json.status conversation.status_value
json.conversation_users do
  json.array! conversation.conversation_users do |conversation_user|
    json.partial! 'api/partial/conversation_user', conversation_user: conversation_user
  end
end
