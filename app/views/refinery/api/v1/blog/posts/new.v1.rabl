object false
node(:attributes) { [*blog_post_attributes] }
node(:required_attributes) { required_fields_for(Refinery::Blog::Post) }