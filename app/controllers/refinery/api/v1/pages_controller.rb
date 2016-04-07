module Refinery
  module Api
    module V1
      class PagesController < Refinery::Api::BaseController

        def index
          respond_with(pages)
        end

        def show
          respond_with(page)
        end

        def create
          authorize! :create, Page
          @page = Page.new(page_params)
          if @page.save
            respond_with(@page, :status => 201, :default_template => :show)
          else
            invalid_resource!(@page)
          end
        end

        def update
          authorize! :update, Page
          if page.update_attributes(page_params)
            respond_with(page, :status => 200, :default_template => :show)
          else
            invalid_resource!(page)
          end
        end

        def destroy
          authorize! :destroy, Page
          page.destroy
          respond_with(page, :status => 204)
        end

        private

        def pages
          @pages = Page.
                    # accessible_by(current_ability, :read).
                    order('lft').includes(root: :children)
        end

        def page
          @page ||= Page.
                      # accessible_by(current_ability, :read).
                      find(params[:id])
        end

        def page_params
          if params[:page] && !params[:page].empty?
            params.require(:page).permit(permitted_page_attributes)
          else
            {}
          end
        end

      end
    end
  end
end