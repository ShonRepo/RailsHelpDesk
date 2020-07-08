require 'rails_helper'

RSpec.describe "Operator::Answers", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/operator/answers/create"
      expect(response).to have_http_status(:success)
    end
  end

end
