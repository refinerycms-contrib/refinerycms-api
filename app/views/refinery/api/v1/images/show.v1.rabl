object @image
attributes :id, :image_size, :image_title, :image_alt

node :image do |image|
  image.image.url
end