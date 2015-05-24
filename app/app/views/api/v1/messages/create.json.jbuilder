json.partial! 'api/partial/conversation', conversation: @conversation
json.users do
  json.array! @users do |user|
    json.partial! 'api/partial/user', user: user
  end
end
