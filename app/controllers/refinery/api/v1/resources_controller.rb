module Refinery
  module Api
    module V1
      class ResourcesController < Refinery::Api::BaseController
        def index
          if params[:ids]
            @resources = Refinery::Resource.
                          includes(:translations).
                          accessible_by(current_ability, :read).
                          where(id: params[:ids].split(','))
          else
            @resources = Refinery::Resource.
                          includes(:translations).
                          accessible_by(current_ability, :read).
                          # load.ransack(params[:q]).result
                          all
          end
          respond_with(@resources)
        end

        def show
          @resource = Refinery::Resource.
                        includes(:translations).
                        accessible_by(current_ability, :read).
                        find(params[:id])
          respond_with(@resource)
        end

        def new
        end

        def create
          authorize! :create, Resource
          @resources = Refinery::Resource.create_resources(resource_params)

          if @resources.all?(&:valid?)
            respond_with(@resources, status: 201, default_template: :show)
          else
            invalid_resource!(@resources)
          end
        end

        def update
          @resource = Refinery::Resource.accessible_by(current_ability, :update).find(params[:id])
          if @resource.update_attributes(resource_params)
            respond_with(@resource, default_template: :show)
          else
            invalid_resource!(@resource)
          end
        end

        def destroy
          @resource = Refinery::Resource.accessible_by(current_ability, :destroy).find(params[:id])
          @resource.destroy
          respond_with(@resource, status: 204)
        end

        private

        def resource_params
          params.require(:resource).permit(permitted_resource_attributes)
        end
      end
    end
  end
end