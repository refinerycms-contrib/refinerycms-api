require 'spec_helper'

module Refinery
  describe Api::V1::PagesController, type: :controller do
    render_views

    let(:page_root) { FactoryGirl.create(:page, :title => "Root") }
    let(:page) { FactoryGirl.create(:page, :title => "Ruby") }
    let(:page2) { FactoryGirl.create(:page, :title => "Rails") }
    let(:page_with_page_part) { FactoryGirl.create(:page_with_page_part) }
    let(:attributes) { ["browser_title", "draft", "link_url", "menu_title", "meta_description", "parent_id", "skip_to_first_child", "show_in_menu", "title", "view_template", "layout_template", "custom_slug", {"parts_attributes"=>["id", "title", "slug", "body", "position"]}] }

    before do
      stub_authentication!
      page2.children << create(:page, title: "3.2.2")
      page.children << page2
      page_root.root.children << page
    end

    context "as a normal user" do
      it "gets all pages" do
        api_get :index

        expect(json_response['pages'].first['title']).to eq page.title
        children = json_response['pages'].first['pages']
        expect(children.count).to eq 1
        expect(children.first['title']).to eq page2.title
        expect(children.first['pages'].count).to eq 1
      end

      it "does not include children when asked not to" do
        api_get :index, without_children: 1

        expect(json_response['pages'].first['title']).to eq(page.title)
        expect(json_response['pages'].first['pages']).to be_nil
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

      it "gets a single page" do
        api_get :show, id: page.id

        expect(json_response['title']).to eq page.title
        expect(json_response['pages'].count).to eq 1
      end

      it "can learn how to create a new page" do
        api_get :new
        expect(json_response["attributes"]).to eq(attributes.map(&:to_s))
        required_attributes = json_response["required_attributes"]
        expect(required_attributes).to include("title")
      end

      it "cannot create a new page if not an admin" do
        api_post :create, page: { title: "Location" }
        assert_unauthorized!
      end

      it "cannot update a page" do
        api_put :update, id: page.id, page: { title: "I hacked your website!" }
        assert_unauthorized!
      end

      it "cannot delete a page" do
        api_delete :destroy, id: page.id
        assert_unauthorized!
      end
    end

    context "as an admin" do
      sign_in_as_admin!

      it "can create" do
        api_post :create, page: { title: "Colors" }
        expect(json_response).to have_attributes(attributes)
        expect(response.status).to eq(201)

        expect(page.reload.root.children.count).to eq 2
        current_page = Refinery::Page.where(title: 'Colors').first

        expect(current_page.parent_id).to eq page.root.id
        expect(current_page.taxonomy_id).to eq page.id
      end

      it "can update the position in the list" do
        page.root.children << page2
        api_put :update, id: page.id, page: { parent_id: page.parent_id, child_index: 2 }
        expect(response.status).to eq(200)
        expect(page.reload.root.children[0]).to eql page2
        expect(page.reload.root.children[1]).to eql page
      end

      it "cannot create a new page with invalid attributes" do
        api_post :create, page: {}
        expect(response.status).to eq(422)
        expect(json_response["error"]).to eq("Invalid resource. Please fix errors and try again.")
        errors = json_response["errors"]

        expect(page.reload.root.children.count).to eq 1
      end

      it "can destroy" do
        api_delete :destroy, :id => page.id
        expect(response.status).to eq(204)
      end
    end

  end
end
