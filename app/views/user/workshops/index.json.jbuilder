json.array!(@workshops) do |workshop|
  json.extract! workshop, :id, :user_id, :description, :details, :start_date, :end_date, :vacancies_number, :value, :prerequisite, :goal, :target_audience, :term
  json.url workshop_url(workshop, format: :json)
end
