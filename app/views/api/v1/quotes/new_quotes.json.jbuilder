json.quotes do
  json.array! @result, partial: "/api/partials/quote", as: :result
end

