json.extract! user_bang, *[:id, :from_user_id, :item_id, :created_at, :updated_at]
json.status user_bang.status_value
json.from_user do
  json.partial! 'api/partial/user', user: user_bang.from_user
end
