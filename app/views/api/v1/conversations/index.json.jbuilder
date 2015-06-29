json.array! @conversations do |conversation|
  json.partial! 'api/partial/conversation', conversation: conversation
end
