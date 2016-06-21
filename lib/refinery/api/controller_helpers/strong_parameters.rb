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
            page_parts_attributes: permitted_page_part_attributes
          ]
        end

        def permitted_resource_attributes
          permitted_attributes.resource_attributes
        end

        def permitted_blog_post_attributes
          permitted_attributes.blog_post_attributes
        end

        def permitted_inquiries_inquiry_attributes
          permitted_attributes.inquiries_inquiry_attributes
        end
      end
    end
  end
end