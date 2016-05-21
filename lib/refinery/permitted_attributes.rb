module Refinery
  module PermittedAttributes
    ATTRIBUTES = [
      :image_attributes,
      :page_attributes,
      :page_part_attributes,
      :resource_attributes
    ]

    mattr_reader *ATTRIBUTES

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