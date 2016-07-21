require 'spec_helper'

module Refinery
  describe Api::V1::Blog::PostsController, type: :controller do
    render_views

    let!(:post) { FactoryGirl.create(:blog_post, :title => "Ruby") }

    let!(:attributes_new) { [ "id", "title", "body", "custom_teaser", "tag_list", "draft", "published_at", "custom_url", "user_id", "username", "browser_title", "meta_description", "source_url", "source_url_title", {"category_ids"=>[]} ] }
    let!(:attributes) { [ "id", "title", "body", "custom_teaser", "tag_list", "draft", "published_at", "custom_url", "user_id", "username", "browser_title", "meta_description", "source_url", "source_url_title", "category_ids" ] }

    before do
      stub_authentication!
    end

    context "as a normal user" do
      it "can get a list of blog posts" do
        api_get :index

        expect(response.status).to eq(200)
        expect(json_response).to have_key("posts")
        attributes.delete("category_ids")
        expect(json_response["posts"].first.keys).to eq(attributes)
      end

      # it "paginates through taxons" do
      #   new_taxon = create(:taxon, :name => "Go", :taxonomy => taxonomy)
      #   taxonomy.root.children << new_taxon
      #   expect(taxonomy.root.children.count).to eql(2)
      #   api_get :index, :taxonomy_id => taxonomy.id, :page => 1, :per_page => 1
      #   expect(json_response["count"]).to eql(1)
      #   expect(json_response["total_count"]).to eql(2)
      #   expect(json_response["current_page"]).to eql(1)
      #   expect(json_response["per_page"]).to eql(1)
      #   expect(json_response["pages"]).to eql(2)
      # end

      # describe 'searching' do
      #   context 'with a name' do
      #     before do
      #       api_get :index, :q => { :name_cont => name }
      #     end

      #     context 'with one result' do
      #       let(:name) { "Ruby" }

      #       it "returns an array including the matching taxon" do
      #         expect(json_response['taxons'].count).to eq(1)
      #         expect(json_response['taxons'].first['name']).to eq "Ruby"
      #       end
      #     end

      #     context 'with no results' do
      #       let(:name) { "Imaginary" }

      #       it 'returns an empty array of taxons' do
      #         expect(json_response.keys).to include('taxons')
      #         expect(json_response['taxons'].count).to eq(0)
      #       end
      #     end
      #   end

      #   context 'with no filters' do
      #     it "gets all taxons" do
      #       api_get :index

      #       expect(json_response['taxons'].first['name']).to eq taxonomy.root.name
      #       children = json_response['taxons'].first['taxons']
      #       expect(children.count).to eq 1
      #       expect(children.first['name']).to eq taxon.name
      #       expect(children.first['taxons'].count).to eq 1
      #     end
      #   end
      # end

      it "gets a single blog post" do
        api_get :show, id: post.id

        expect(json_response['title']).to eq post.title
        expect(json_response['posts']).to be_nil
      end

      it "can learn how to create a new blog post" do
        api_get :new
        expect(json_response["attributes"]).to eq(attributes_new)
        required_attributes = json_response["required_attributes"]
        expect(required_attributes).to include("title")
      end

      it "cannot create a new blog post if not an admin" do
        api_post :create, blog_post: { title: "Location" }
        assert_unauthorized!
      end

      it "cannot update a blog post" do
        api_put :update, id: post.id, post: { title: "I hacked your website!" }
        assert_unauthorized!
      end

      it "cannot delete a blog post" do
        api_delete :destroy, id: post.id
        assert_unauthorized!
      end
    end

    context "as an admin" do
      sign_in_as_admin!

      it "can create" do
        expect do
          api_post :create, post: { title: "Colors", body: "Colors of life", published_at: Time.now, username: "John Doe" }
          attributes.delete("category_ids")
          expect(json_response.keys).to eq(attributes)
          expect(response.status).to eq(201)
        end.to change(Blog::Post, :count).by(1)
      end

      it "can update the title" do
        api_put :update, id: post.id, post: { title: "I update your website!" }
        expect(response.status).to eq(200)
        expect(Blog::Post.last.title).to eql "I update your website!"
      end

      it "cannot create a new blog post with invalid attributes" do
        api_post :create, post: {}
        expect(response.status).to eq(422)
        expect(json_response["error"]).to eq("Invalid resource. Please fix errors and try again.")
        errors = json_response["errors"]

        expect(Blog::Post.count).to eq 1
      end

      it "can destroy" do
        api_delete :destroy, :id => post.id
        expect(response.status).to eq(204)
      end
    end

  end
end
