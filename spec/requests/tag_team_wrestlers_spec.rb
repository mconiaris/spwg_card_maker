require 'rails_helper'

RSpec.describe "TagTeamWrestlers", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/tag_team_wrestlers/index"
      expect(response).to have_http_status(:success)
    end
  end

end
