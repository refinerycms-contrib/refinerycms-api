object false
node(:attributes) { [*taxon_attributes] }
node(:required_attributes) { required_fields_for(Refinery::Taxon) }
