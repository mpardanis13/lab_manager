Rswag::Ui.configure do |c|
  # Τώρα του λέμε να πάρει το αρχείο απευθείας από το public url
  c.openapi_endpoint '/api-docs/v1/swagger.yaml', 'API V1 Docs'
end