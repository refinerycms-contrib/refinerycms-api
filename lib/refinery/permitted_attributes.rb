module Refinery
  module PermittedAttributes
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

    @@blog_post_attributes = [
      :title, :body, :custom_teaser, :tag_list,
      :draft, :published_at, :custom_url, :user_id, :username, :browser_title,
      :meta_description, :source_url, :source_url_title, category_ids: []
    ]

    @@inquiries_inquiry_attributes = [:name, :phone, :message, :email]

    @@image_page_attributes = [
      :image_id, :page_id, :position, :caption, :page_type
    ]
  end
end