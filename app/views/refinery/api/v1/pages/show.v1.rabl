object @page

cache [I18n.locale, 'show', root_object]

attributes *page_attributes

child :parts => :page_parts do
  attributes *page_part_attributes
end

if defined? Refinery::PageImages
  child :image_pages => :image_pages do
    attributes *image_page_attributes

    child image: :image do
      extends "refinery/api/v1/images/show"
    end
  end
end