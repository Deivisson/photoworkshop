json.array!(@workshop_activity_responses) do |workshop_activity_response|
  json.extract! workshop_activity_response, :id, :user_id, :workshop_id
  json.url workshop_activity_response_url(workshop_activity_response, format: :json)
end
