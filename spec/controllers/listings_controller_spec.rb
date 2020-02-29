require 'rails_helper'

RSpec.describe ListingsController, type: :controller do

  describe "GET #listing" do
    it "returns http success" do
      get :listing
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #in_progress" do
    it "returns http success" do
      get :in_progress
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #completed" do
    it "returns http success" do
      get :completed
      expect(response).to have_http_status(:success)
    end
  end

end
