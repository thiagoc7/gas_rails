json.clients(@clients) do |client|
  json.extract! client, :id, :name, :document, :ref
  json.url client_url(client, format: :json)
end
