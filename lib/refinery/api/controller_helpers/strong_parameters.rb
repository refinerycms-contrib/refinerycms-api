module Refinery
  module Api
    module ControllerHelpers
      module StrongParameters
        def permitted_attributes
          Refinery::PermittedAttributes
        end

        delegate *Refinery::PermittedAttributes::ATTRIBUTES,
                 to: :permitted_attributes,
                 prefix: :permitted

        def permitted_image_attributes
          permitted_attributes.image_attributes
        end

        def permitted_page_attributes
          permitted_attributes.page_attributes + [
            page_parts_attributes: permitted_page_parts_attributes
          ]
        end

        def permitted_resource_attributes
          permitted_attributes.resource_attributes
        end
      end
    end
  end
end