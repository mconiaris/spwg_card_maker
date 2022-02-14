require 'rails_helper'

RSpec.describe "Welcomes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/welcome/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get "/welcome/about"
      expect(response).to have_http_status(:success)
    end
  end

end
