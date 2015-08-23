json.extract! group_bang, *[:id, :group_id, :from_group_id, :item_id, :created_at, :updated_at]
json.status group_bang.status_value
json.from_group do
  json.partial! 'api/partial/group', group: group_bang.from_group
end
