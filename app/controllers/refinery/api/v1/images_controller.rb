module Refinery
  module Api
    module V1
      class ImagesController < Refinery::Api::BaseController
        def index
          if params[:ids]
            @images = Refinery::Image.
                        includes(:translations).
                        # accessible_by(current_ability, :read).
                        where(id: params[:ids].split(','))
          else
            @images = Refinery::Image.
                        includes(:translations).
                        # accessible_by(current_ability, :read).
                        # load.ransack(params[:q]).result
                        all
          end
          respond_with(@images)
        end

        def show
          @image = Refinery::Image.
                    includes(:translations).
                    # accessible_by(current_ability, :read).
                    find(params[:id])
          respond_with(@image)
        end

        private

        def image_params
          params.require(:image).permit(permitted_image_attributes)
        end
      end
    end
  end
end