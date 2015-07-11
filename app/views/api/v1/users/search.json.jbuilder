json.array! @users do |user|
  json.partial! 'api/partial/user', user: user
end
