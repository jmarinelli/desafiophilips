json.array!(@sales) do |sale|
  json.extract! sale, :id, :product_id, :user_id
  json.url sale_url(sale, format: :json)
end
