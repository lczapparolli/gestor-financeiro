json.array!(@forecasts) do |forecast|
  json.extract! forecast, :id, :period_id, :budget_id, :amount
  json.url forecast_url(forecast, format: :json)
end
