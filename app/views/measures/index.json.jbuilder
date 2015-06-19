json.array!(@measures) do |measure|
  json.extract! measure, :id, :plan_id, :tank_id, :volume
  json.url measure_url(measure, format: :json)
end
