require 'spec_helper'

module Refinery
  describe Api::V1::Inquiries::InquiriesController, type: :controller do
    render_views

    let!(:inquiry) { FactoryGirl.create(:inquiry) }

    let!(:attributes) { [ "id", "name", "phone", "message", "email"] }

    before do
      stub_authentication!
    end

    context "as a normal user" do
      sign_in_as_user!

      it "can learn how to create a new inquiry" do
        api_get :new
        expect(json_response["attributes"]).to eq(attributes)
        required_attributes = json_response["required_attributes"]
        expect(required_attributes).to include("name")
      end

      it "can create" do
        expect do
          api_post :create, inquiry: { name: "John Doe", message: "Hello world!", email: "refinery@example.org" }
          expect(json_response.keys).to eq(attributes)
          expect(response.status).to eq(201)
        end.to change(Inquiries::Inquiry, :count).by(1)
      end

      it "cannot create a new inquiry with invalid attributes" do
        api_post :create, inquiry: {}
        expect(response.status).to eq(422)
        expect(json_response["error"]).to eq("Invalid resource. Please fix errors and try again.")
        errors = json_response["errors"]

        expect(Inquiries::Inquiry.count).to eq 1
      end

      it "cannot get a list of inquiries" do
        api_get :index
        assert_unauthorized!
      end

      it "cannot gets a single inquiry" do
        api_get :show, id: inquiry.id
        assert_unauthorized!
      end

      it "cannot delete a inquiry" do
        api_delete :destroy, id: inquiry.id
        assert_unauthorized!
      end
    end

    context "as an admin" do
      sign_in_as_admin!

      it "can get a list of inquiries" do
        api_get :index

        byebug

        expect(response.status).to eq(200)
        expect(json_response).to have_key("inquiries")
        expect(json_response["inquiries"].first.keys).to eq(attributes)
      end

      it "gets a single inquiry" do
        api_get :show, id: inquiry.id

        expect(json_response['name']).to eq inquiry.name
        expect(json_response['inquiries']).to be_nil
      end

      it "can destroy" do
        api_delete :destroy, :id => inquiry.id
        expect(response.status).to eq(204)
      end
    end

  end
end
