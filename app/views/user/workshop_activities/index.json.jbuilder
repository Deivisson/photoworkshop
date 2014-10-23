json.array!(@workshop_activities) do |workshop_activity|
  json.extract! workshop_activity, :id, :description, :details, :status, :limit_date
  json.url workshop_activity_url(workshop_activity, format: :json)
end
