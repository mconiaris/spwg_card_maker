require 'rails_helper'

RSpec.describe "SortWrestlers", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/sort_wrestlers/index"
      expect(response).to have_http_status(:success)
    end
  end

end
