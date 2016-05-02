object @page
attributes *page_attributes

child :parts => :page_parts do
  attributes *page_part_attributes
end