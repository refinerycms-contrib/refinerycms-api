require 'spec_helper'

module Refinery
  describe "User", type: :model do
    before do
      allow(Refinery::Api).to receive(:user_class).and_return(Refinery::Authentication::Devise::User)
    end

    let(:user) { Refinery::Api.user_class.new }

    it "can generate an API key" do
      expect(user).to receive(:save!)
      user.generate_refinery_api_key!
      expect(user.refinery_api_key).not_to be_blank
    end

    it "can clear an API key" do
      expect(user).to receive(:save!)
      user.clear_refinery_api_key!
      expect(user.refinery_api_key).to be_blank
    end
  end
end
