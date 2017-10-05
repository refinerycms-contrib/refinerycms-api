object false
node(:error) { I18n.t(:invalid_resource, :scope => "refinery.api") }
node(:errors) { Array(@resource).map{|r| r.errors.to_hash } }
