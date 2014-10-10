json.array!(@places) do |place|
  json.extract! place, :id, :name, :full_name, :description, :rewards, :image_url
  json.url place_url(place, format: :json)
end
