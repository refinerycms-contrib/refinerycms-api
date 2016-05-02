object false
node(:count) { @images.count }
node(:total_count) { @images.total_count }
node(:current_page) { params[:page] ? params[:page].to_i : 1 }
node(:per_page) { params[:per_page] || Kaminari.config.default_per_page }
node(:pages) { @images.num_pages }
child(@images => :images) do
  extends "spree/api/v1/images/show"
end