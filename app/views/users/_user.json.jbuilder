json.extract! user, :id, :first_name, :last_name, :email, :phone, :access_token, :auth_code, :created_at, :updated_at
json.url user_url(user, format: :json)
