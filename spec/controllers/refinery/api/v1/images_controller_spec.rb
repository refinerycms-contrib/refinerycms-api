require 'spec_helper'

module Refinery
  describe Api::V1::ImagesController, type: :controller  do
    render_views

    let!(:attributes_new) { [ { "image" => [] }, "image_size", "image_title", "image_alt" ] }
    let!(:attributes) { [ "image", "image_size", "image_title", "image_alt" ] }

    before do
      stub_authentication!
    end

    context "as an admin" do
      sign_in_as_admin!

      it "can learn how to create a new image" do
        api_get :new
        expect(json_response["attributes"]).to eq(attributes_new)
        required_attributes = json_response["required_attributes"]
        expect(required_attributes).to include("image")
      end

      it "can upload a new image" do
        expect do
          api_post :create, image: { image: [upload_file('thinking-cat.jpg', 'image/jpg')] }
          expect(response.message).to eq(201)
          expect(json_response).to have_attributes(attributes)
        end.to change(Image, :count).by(1)
      end

      it "can't upload a new image without attachment" do
        api_post :create, image: {}
        expect(response.status).to eq(422)
      end

      context "working with an existing image" do
        let!(:image) { FactoryGirl.create(:image) }

        it "can get a single image" do
          api_get :show, id: image.id
          expect(response.status).to eq(200)
          expect(json_response).to have_attributes(attributes)
        end

        it "can get a list of images" do
          api_get :index
          expect(response.status).to eq(200)
          expect(json_response).to have_key("images")
          expect(json_response["images"].first).to have_attributes(attributes)
        end

        it "can update image data" do
          expect(image.image_title).to eq(nil)
          api_post :update, image: { image_title: "test" }, id: image.id
          expect(response.status).to eq(200)
          expect(json_response).to have_attributes(attributes)
          expect(image.reload.image_title).to eq('test')
        end

        it "can't update a image without attachment" do
          api_post :update,
                   image: {},
                   id: image.id
          expect(response.status).to eq(422)
        end

        it "can delete an image" do
          api_delete :destroy, id: image.id
          expect(response.status).to eq(204)
          expect { image.reload }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context "as a non-admin" do
      it "cannot create an image" do
        api_post :create
        assert_unauthorized!
      end

      it "cannot update an image" do
        api_put :update, id: 1
        assert_not_found!
      end

      it "cannot delete an image" do
        api_delete :destroy, id: 1
        assert_not_found!
      end
    end
  end
end