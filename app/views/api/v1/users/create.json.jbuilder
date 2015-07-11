json.partial! 'api/partial/user', user: @user
json.token @user.token
json.is_new @is_new
