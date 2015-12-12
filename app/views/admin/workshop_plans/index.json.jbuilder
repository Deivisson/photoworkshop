json.array!(@workshop_plans) do |workshop_plan|
  json.extract! workshop_plan, :id, :description, :settings, :active
  json.url workshop_plan_url(workshop_plan, format: :json)
end
