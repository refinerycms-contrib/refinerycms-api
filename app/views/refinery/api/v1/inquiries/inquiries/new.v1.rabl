object false
node(:attributes) { [*inquiries_inquiry_attributes] }
node(:required_attributes) { required_fields_for(Refinery::Inquiries::Inquiry) }