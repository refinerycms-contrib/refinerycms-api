attributes *page_attributes

node :pages do |t|
  t.children.map { |c| partial("refinery/api/v1/pages/pages", :object => c) }
end