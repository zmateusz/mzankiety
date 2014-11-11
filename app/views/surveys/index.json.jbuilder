json.array!(@surveys) do |survey|
  json.extract! survey, :id, :name, :descr, :author
  json.url survey_url(survey, format: :json)
end
