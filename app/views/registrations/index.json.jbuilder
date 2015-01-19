json.array!(@registrations) do |registration|
  json.extract! registration, :id, :user_id, :gcm_reg_id
  json.url registration_url(registration, format: :json)
end
