object @page

if params[:set] == 'nested'
  extends "spree/api/v1/pages/nested"
else
  attributes *page_attributes

  child root: :page_parts do
    attributes *page_part_attributes
  end
end