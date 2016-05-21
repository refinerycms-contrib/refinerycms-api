module Refinery
  module Api
    module V1
      class PagesController < Refinery::Api::BaseController

        def index
          if params[:ids]
            @pages = Refinery::Page.
                      includes(:translations, :children).
                      accessible_by(current_ability, :read).
                      where(id: params[:ids].split(','))
          else
            @pages = Refinery::Page.
                      includes(:translations, :children).
                      accessible_by(current_ability, :read).
                      # ransack(params[:q]).result
                      order(:lft)
          end

          respond_with(@pages)
        end

        def show
          @page = page
          respond_with(@page)
        end

        def new
        end

        def create
          authorize! :create, Page
          @page = Refinery::Page.new(page_params)

          if @page.save
            respond_with(@page, status: 201, default_template: :show)
          else
            invalid_resource!(@page)
          end
        end

        def update
          authorize! :update, page
          if page.update_attributes(page_params)
            respond_with(page, status: 200, default_template: :show)
          else
            invalid_resource!(tpageaxon)
          end
        end

        def destroy
          authorize! :destroy, page
          page.destroy
          respond_with(page, status: 204)
        end

        private

        def page
          @page ||= Refinery::Page.
                      includes(:translations, :parts).
                      accessible_by(current_ability, :read).
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