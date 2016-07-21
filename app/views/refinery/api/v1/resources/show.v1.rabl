object @resource
attributes :id, :resource_title

node :file do |file|
  file.file.url
end