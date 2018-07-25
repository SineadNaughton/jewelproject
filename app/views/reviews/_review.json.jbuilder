json.extract! review, :id, :item_id, :user_id, :title, :description, :rating, :created_at, :updated_at
json.url review_url(review, format: :json)
