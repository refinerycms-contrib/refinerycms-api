object false
node(:count) { @resources.count }
child(@resources => :resources) do
  extends "refinery/api/v1/resources/show"
end