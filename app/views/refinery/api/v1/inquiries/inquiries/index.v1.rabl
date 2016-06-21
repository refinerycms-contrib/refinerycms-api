object false
node(:count) { @inquiries.count }
child @inquiries => :inquiries do
  extends "refinery/api/v1/inquiries/inquiries/show"
end