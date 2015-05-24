json.extract! conversation, *[:id, :created_at, :updated_at]
json.kind conversation.kind_value

# TODO : 全件返してるけど絞って返す
json.messages do
  json.array! conversation.messages do |message|
    json.partial! 'api/partial/message', message: message
  end
end
