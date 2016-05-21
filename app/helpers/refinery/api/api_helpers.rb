module Refinery
  module Api
    module ApiHelpers
      ATTRIBUTES = [
        :image_attributes,
        :page_attributes,
        :page_part_attributes,
        :resource_attributes
      ]

      mattr_reader *ATTRIBUTES

      def required_fields_for(model)
        required_fields = model._validators.select do |field, validations|
          validations.any? { |v| v.is_a?(ActiveModel::Validations::PresenceValidator) }
        end.map(&:first) # get fields that are invalid
        # Permalinks presence is validated, but are really automatically generated
        # Therefore we shouldn't tell API clients that they MUST send one through
        required_fields.map!(&:to_s).delete("permalink")
        # Do not require slugs, either
        required_fields.delete("slug")
        required_fields
      end

      @@image_attributes = [
        { image: [] }, :image_size, :image_title, :image_alt
      ]

      @@page_attributes = [
        :browser_title, :draft, :link_url, :menu_title, :meta_description,
        :parent_id, :skip_to_first_child, :show_in_menu, :title, :view_template,
        :layout_template, :custom_slug, parts_attributes: [:id, :title, :slug, :body, :position]
      ]

      @@page_part_attributes = [
        :title, :slug, :body, :locale
      ]

      @@resource_attributes = [
        :resource_title, { file: [] }
      ]
    end
  end
end