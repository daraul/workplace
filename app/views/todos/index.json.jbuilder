json.array!(@todos) do |todo|
  json.extract! todo, :id, :title, :description, :completed
  json.url todo_url(todo, format: :json)
end
