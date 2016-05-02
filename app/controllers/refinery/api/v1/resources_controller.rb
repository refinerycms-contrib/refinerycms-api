module Refinery
  module Api
    module V1
      class ResourcesController < Refinery::Api::BaseController
        def index
          if params[:ids]
            @resources = Refinery::Resource.
                          includes(:translations).
                          # accessible_by(current_ability, :read).
                          where(id: params[:ids].split(','))
          else
            @resources = Refinery::Resource.
                          includes(:translations).
                          # accessible_by(current_ability, :read).
                          load.ransack(params[:q]).result
          end
          respond_with(@resources)
        end

        def show
          @resource = Refinery::Resource.
                        includes(:translations).
                        # accessible_by(current_ability, :read).
                        find(params[:id])
          respond_with(@resource)
        end

        private

        def resource_params
          params.require(:resource).permit(permitted_resource_attributes)
        end
      end
    end
  end
end