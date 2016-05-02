object false
node(:attributes) { [*resource_attributes] }
node(:required_attributes) { required_fields_for(Refinery::Resource) }