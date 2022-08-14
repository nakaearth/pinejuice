# fronzen_string_literal: true

json.array! @tickets do |ticket|
  json.id ticket[:id]
  json.title ticket[:title]
  json.distription ticket[:description]
end
