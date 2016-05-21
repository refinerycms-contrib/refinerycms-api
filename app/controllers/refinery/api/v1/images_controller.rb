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
          @images = []
          begin
            if params[:image].present? && params[:image][:image].is_a?(Array)
              params[:image][:image].each do |image|
                params[:image][:image_title] = params[:image][:image_title].presence || auto_title(image.original_filename)
                @images << (@image = ::Refinery::Image.create({image: image}.merge(image_params.except(:image))))
              end
            else
              @images << (@image = ::Refinery::Image.create(image_params))
            end
          rescue NotImplementedError
            logger.warn($!.message)
            @image = ::Refinery::Image.new
          end

          if @images.all?(&:valid?)
            respond_with(@images, status: 201, default_template: :show)
          else
            invalid_resource!(@images)
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

        protected

        def auto_title(filename)
          CGI::unescape(filename.to_s).gsub(/\.\w+$/, '').titleize
        end

        private

        def image_params
          params.require(:image).permit(permitted_image_attributes)
        end
      end
    end
  end
end