#json.partial! 'api/partial/group', group: @group
json.array! @groups do |group|
  json.partial! 'api/partial/group', group: group
end
