module Refinery
  module Api
    module ApiHelpers
      ATTRIBUTES = [
        :image_attributes,
        :page_attributes,
        :page_part_attributes,
        :resource_attributes,
        :blog_post_attributes,
        :inquiries_inquiry_attributes,
        :image_page_attributes
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
        :id, { image: [] }, :image_size, :image_title, :image_alt
      ]

      @@page_attributes = [
        :id, :browser_title, :draft, :link_url, :menu_title, :meta_description,
        :parent_id, :skip_to_first_child, :show_in_menu, :title, :view_template,
        :layout_template, :custom_slug, parts_attributes: [:id, :title, :slug, :body, :position]
      ]

      @@page_part_attributes = [
        :id, :title, :slug, :body, :locale
      ]

      @@resource_attributes = [
        :id, :resource_title, { file: [] }
      ]

      @@blog_post_attributes = [
        :id, :title, :body, :custom_teaser, :tag_list,
        :draft, :published_at, :custom_url, :user_id, :username, :browser_title,
        :meta_description, :source_url, :source_url_title, category_ids: []
      ]

      @@inquiries_inquiry_attributes = [
        :id, :name, :phone, :message, :email
      ]

      @@image_page_attributes = [
        :image_id, :page_id, :position, :caption, :id, :page_type
      ]
    end
  end
end