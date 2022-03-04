require 'rails_helper'

RSpec.describe "WrestlersPrinters", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/wrestlers_printer/show"
      expect(response).to have_http_status(:success)
    end
  end

end
