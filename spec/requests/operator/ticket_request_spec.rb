require 'rails_helper'

RSpec.describe "Operator::Tickets", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/operator/ticket/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/operator/ticket/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/operator/ticket/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/operator/ticket/update"
      expect(response).to have_http_status(:success)
    end
  end

end
