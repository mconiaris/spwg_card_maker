require 'rails_helper'

RSpec.describe "WrestlerTemplates", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/wrestler_templates/new"
      expect(response).to have_http_status(:success)
    end
  end

end
