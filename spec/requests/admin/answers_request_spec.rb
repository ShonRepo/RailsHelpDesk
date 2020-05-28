require 'rails_helper'

RSpec.describe "Admin::Answers", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/admin/answers/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/admin/answers/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/admin/answers/destroy"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/admin/answers/new"
      expect(response).to have_http_status(:success)
    end
  end

end
