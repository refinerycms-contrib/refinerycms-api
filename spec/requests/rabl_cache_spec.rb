require 'spec_helper'

describe "Rabl Cache", type: :request, caching: true do
  before do
    allow(Refinery::Api).to receive(:requires_authentication).and_return(false)

    create(:page)
    expect(Refinery::Page.count).to eq(1)
  end

  it "doesn't create a cache key collision for models with different rabl templates" do
    get "/api/v1/pages"
    expect(response.status).to eq(200)

    # pending
  end
end
