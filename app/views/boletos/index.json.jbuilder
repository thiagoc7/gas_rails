json.array!(@boletos) do |boleto|
  json.extract! boleto, :id, :amount, :discount, :date, :maturity, :days_to_maturity, :doc_number
  json.url boleto_url(boleto, format: :json)
end
