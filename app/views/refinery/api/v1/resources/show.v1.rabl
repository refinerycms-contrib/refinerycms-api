object @resource
attributes :resource_title

node :file do |file|
  file.file.url
end