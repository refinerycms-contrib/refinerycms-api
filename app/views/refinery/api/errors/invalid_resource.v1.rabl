object false
node(:error) { I18n.t(:invalid_resource, :scope => "refinery.api") }
node(:errors) { @resource.errors.to_hash }
