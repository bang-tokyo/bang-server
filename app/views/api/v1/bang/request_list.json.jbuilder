json.array! @user_bangs do |user_bang|
  json.partial! 'api/partial/user_bang', user_bang: user_bang
end
