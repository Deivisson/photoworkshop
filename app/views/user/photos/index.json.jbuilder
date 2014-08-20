json.array!(@photos) do |photo|
  json.extract! photo, :id, :user_id, :category_id, :title, :description, :tags, :camera, :lens, :aperture, :shutter_speed, :taken_at, :focal_lenght, :iso
  json.url photo_url(photo, format: :json)
end
