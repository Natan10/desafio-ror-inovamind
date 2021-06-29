json.quotes do
  json.array! @quotes, partial: "/api/partials/quote", as: :result
end
