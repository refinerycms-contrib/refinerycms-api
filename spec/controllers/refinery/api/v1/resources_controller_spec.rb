require 'spec_helper'

module Refinery
  describe Api::V1::ResourcesController, type: :controller do
    render_views

    let!(:attributes_new) { [ "resource_title", { "file" => [] } ] }
    let!(:attributes) { [ "resource_title", "resource" ] }

    before do
      stub_authentication!
    end

    context "as an admin" do
      sign_in_as_admin!

      it "can learn how to create a new resource" do
        api_get :new
        expect(json_response["attributes"]).to eq(attributes_new)
        required_attributes = json_response["required_attributes"]
        expect(required_attributes).to include("file")
      end

      it "can upload a new resource" do
        expect do
          api_post :create, resource: { file: [upload_file('refinery_is_awesome.txt', 'text/plain')] }
          expect(response.status).to eq(201)
          expect(json_response).to have_attributes(attributes)
        end.to change(Resource, :count).by(1)
      end

      it "can't upload a new resource without attachment" do
        api_post :create, resource: {}
        expect(response.status).to eq(422)
      end

      context "working with an existing resource" do
        let!(:resource) { FactoryGirl.create(:resource) }

        it "can get a single resource" do
          api_get :show, id: resource.id
          expect(response.status).to eq(200)
          expect(json_response).to have_attributes(attributes)
        end

        it "can get a list of resources" do
          api_get :index
          expect(response.status).to eq(200)
          expect(json_response).to have_key("resources")
          expect(json_response["resources"].first).to have_attributes(attributes)
        end

        it "can update resource data" do
          expect(resource.resource_title).to eq(nil)
          api_post :update, resource: { resource_title: "test" }, id: resource.id
          expect(response.status).to eq(200)
          expect(json_response).to have_attributes(attributes)
          expect(resource.reload.resource_title).to eq('test')
        end

        it "can't update a resource without attachment" do
          api_post :update,
                   resource: nil,
                   id: resource.id
          expect(response.status).to eq(422)
        end

        it "can delete an resource" do
          api_delete :destroy, id: resource.id
          expect(response.status).to eq(204)
          expect { resource.reload }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context "as a non-admin" do
      it "cannot create an resource" do
        api_post :create
        assert_unauthorized!
      end

      it "cannot update an resource" do
        api_put :update, id: 1
        assert_not_found!
      end

      it "cannot delete an resource" do
        api_delete :destroy, id: 1
        assert_not_found!
      end
    end
  end
end