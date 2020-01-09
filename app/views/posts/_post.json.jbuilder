json.extract! post, :id, :title, :description, :belongs_to, :created_at, :updated_at
json.url post_url(post, format: :json)
