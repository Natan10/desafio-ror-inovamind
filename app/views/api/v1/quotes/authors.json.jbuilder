json.authors do 
  json.array! @authors do |a|
    json.name a[0]
    json.about a[1]
  end
end