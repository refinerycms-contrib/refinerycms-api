object false
node(:count) { @images.count }
child(@images => :images) do
  extends "refinery/api/v1/images/show"
end