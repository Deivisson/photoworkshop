json.array!(@photo_comments) do |photo_comment|
  json.extract! photo_comment, :id, :user_id, :photo_id, :content
  json.url photo_comment_url(photo_comment, format: :json)
end
