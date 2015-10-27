json.array!(@movements) do |movement|
  json.extract! movement, :id, :description, :date, :amount, :account_id, :budget_id, :period_id
  json.url movement_url(movement, format: :json)
end
