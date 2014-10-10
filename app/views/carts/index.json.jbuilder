json.array!(@carts) do |cart|
  json.extract! cart, :id, :user_id, :place_id, :points
  json.url cart_url(cart, format: :json)
end
