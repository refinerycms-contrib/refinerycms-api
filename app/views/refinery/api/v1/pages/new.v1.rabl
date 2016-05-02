object false
node(:attributes) { [*page_attributes] }
node(:required_attributes) { required_fields_for(Refinery::Page) }