object false
node(:count) { @pages.count }
child @pages => :pages do
  attributes *page_attributes
  unless params[:without_children]
    extends "refinery/api/v1/pages/pages"
  end
end