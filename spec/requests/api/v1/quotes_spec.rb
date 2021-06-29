require "rails_helper"

RSpec.describe "Api::V1::Quotes", type: :request do
  subject(:auth_user) do
    post "/api/authentication", params: {user: {email: user.email, password: user.password}}
    token = response.body
    JSON.parse(token)["token"]
  end
  let(:user) { create(:user) }
  let(:token) {auth_user}

  describe "GET /search_tag" do

    let(:create_quotes) do 
      list = []
      list << create(:quote,tags: ["love","angry"])
      list << create(:quote,tags: ["angry"])
      list << create(:quote,tags: ["love","humor"])
    end

    it "valid tag" do 
      quotes = create_quotes
      get "/api/quotes/love", 
      headers: {"Authorization": "Bearer #{token}"}

      result = JSON.parse(response.body).to_h
      expect(result["quotes"].count).to eq(2)
      expect(response).to have_http_status(:ok)
    end

    it "invalid tag" do 
      get "/api/quotes/teste", 
      headers: {"Authorization": "Bearer #{token}"}

      result = JSON.parse(response.body).to_h 
      expect(response).to have_http_status(:ok)
      expect(result["quotes"].count).to eq(0)
    end

    it "return authors" do 
      quote1 = create(:quote,author: "test1") 
      quote2 = create(:quote,author: "test2")
      get "/api/quotes/authors", 
      headers: {"Authorization": "Bearer #{token}"}

      result = JSON.parse(response.body).to_h
      expect(result["authors"][0]["name"]).to eq(quote1.author) 
    end
  end
end
