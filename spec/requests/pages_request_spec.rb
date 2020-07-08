require 'rails_helper'

RSpec.describe "Pages", type: :request do

  describe "GET /start" do
    it "returns http success" do
      get "/pages/start"
      expect(response).to have_http_status(:success)
    end
  end

end
