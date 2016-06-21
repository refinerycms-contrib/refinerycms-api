object false
node(:count) { @posts.count }
child @posts => :posts do
  extends "refinery/api/v1/blog/posts/show"
end