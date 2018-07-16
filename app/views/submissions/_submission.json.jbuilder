json.extract! submission, :id, :title, :url, :user_id, :created_at, :updated_at
json.url submission_url(submission, format: :json)
