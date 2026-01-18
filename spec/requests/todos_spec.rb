require 'rails_helper'

RSpec.describe "Todos API", type: :request do
  let(:headers) { { "Accept" => "application/json" } }

  describe "GET /todos" do
    it "επιστρέφει σφάλμα 401 αν δεν υπάρχει token" do
      # Στέλνουμε το αίτημα ως JSON για να πάρουμε 401 και όχι redirect
      get "/todos", headers: headers
      expect(response).to have_http_status(401)
    end
  end

  describe "POST /signup" do
    let(:valid_attributes) do
      { name: 'Makis', email: "test_#{rand(1000)}@test.com", password: 'password123', password_confirmation: 'password123' }
    end

    it "δημιουργεί έναν νέο χρήστη και επιστρέφει token" do
      post "/signup", params: valid_attributes, headers: headers
      expect(response).to have_http_status(201)
      expect(JSON.parse(response.body)).to have_key('auth_token')
    end
  end
end