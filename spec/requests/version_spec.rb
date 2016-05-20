require 'spec_helper'

describe "Version", type: :request do
  let!(:pages) { 2.times.map { FactoryGirl.create(:page) } }

  before do
    allow(Refinery::Api).to receive(:requires_authentication).and_return(false)
  end

  describe "/api" do
    it "be a redirect" do
      get "/api/pages"
      expect(response).to have_http_status 301
    end
  end

  describe "/api/v1" do
    it "be successful" do
      get "/api/v1/pages"
      expect(response).to have_http_status 200
    end
  end
end
