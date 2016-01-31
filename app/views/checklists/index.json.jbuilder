json.array!(@checklists) do |checklist|
  json.extract! checklist, :id, :title, :description
  json.url checklist_url(checklist, format: :json)
end
