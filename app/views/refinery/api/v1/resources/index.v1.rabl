object false
node(:count) { @resources.count }
node(:total_count) { @resources.total_count }
node(:current_page) { params[:page] ? params[:page].to_i : 1 }
node(:per_page) { params[:per_page] || Kaminari.config.default_per_page }
node(:pages) { @resources.num_pages }
child(@resources => :resources) do
  extends "spree/api/v1/resources/show"
end