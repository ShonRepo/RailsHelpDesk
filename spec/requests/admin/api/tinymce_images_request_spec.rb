require 'rails_helper'

RSpec.describe "Admin::Api::TinymceImages", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/admin/api/tinymce_images/create"
      expect(response).to have_http_status(:success)
    end
  end

end
