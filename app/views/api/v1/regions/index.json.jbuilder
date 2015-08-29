json.array! @regions do |region|
  json.partial! 'api/partial/region', region: region
end
