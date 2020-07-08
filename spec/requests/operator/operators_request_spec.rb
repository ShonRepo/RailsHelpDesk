require 'rails_helper'

RSpec.describe "Operator::Operators", type: :request do

  describe "GET /edit" do
    it "returns http success" do
      get "/operator/operators/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/operator/operators/update"
      expect(response).to have_http_status(:success)
    end
  end

end
