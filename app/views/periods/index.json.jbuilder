json.array!(@periods) do |period|
  json.extract! period, :id, :name, :start, :end
  json.url period_url(period, format: :json)
end
