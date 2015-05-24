json.conversations do
  json.partial! 'api/partial/conversation', conversation: @conversation
end

# TODO : 全件返してるけど絞って返す
json.messages do
  json.array! @conversation.messages do |message|
    json.partial! 'api/partial/message', message: message
  end
end

json.users do
  json.array! @users do |user|
    json.partial! 'api/partial/user', user: user
  end
end
