object @page

cache [I18n.locale, 'show', root_object]

attributes *page_attributes

child :parts => :page_parts do
  attributes *page_part_attributes
end