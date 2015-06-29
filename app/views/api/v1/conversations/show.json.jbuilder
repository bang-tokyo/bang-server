json.array! @conversation.messages do |message|
  json.partial! 'api/partial/message', message: message
end
