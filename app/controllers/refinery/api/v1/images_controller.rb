module Refinery
  module Api
    module V1
      class ImagesController < Refinery::Api::BaseController
        def index
          @images = Refinery::Image.
                      includes(:translations).
                      accessible_by(current_ability, :read)
          respond_with(@images)
        end

        def show
          @image = Refinery::Image.
                    includes(:translations).
                    accessible_by(current_ability, :read).
                    find(params[:id])
          respond_with(@image)
        end

        def new
        end

        def create
          authorize! :create, Image
          @image = Refinery::Image.new(image_params)
          if @image.save
            respond_with(@image, status: 201, default_template: :show)
          else
            invalid_resource!(@image)
          end
        end

        def update
          @image = Refinery::Image.accessible_by(current_ability, :update).find(params[:id])
          if @image.update_attributes(image_params)
            respond_with(@image, default_template: :show)
          else
            invalid_resource!(@image)
          end
        end

        def destroy
          @image = Refinery::Image.accessible_by(current_ability, :destroy).find(params[:id])
          @image.destroy
          respond_with(@image, status: 204)
        end

        private

        def image_params
          params.require(:image).permit(permitted_image_attributes)
        end
      end
    end
  end
end