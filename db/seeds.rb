# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def generate_node_data
  {
    first_name: FFaker::Name.first_name,
    last_name: FFaker::Name.last_name,
    job_title: FFaker::Job.title
  }
end

def generate_children(node)
  data = (Random.rand(5) + 2).times.map { |i| generate_node_data.merge({ parent_id: node.id }) }
  Node.create(data)
end

# build 4 levels of data to play around with
root = Node.create(generate_node_data.merge({ root: true, job_title: "CEO" }))
children = generate_children(root)
children.each do |child_node|
  grandchildren = generate_children(child_node)
  grandchildren.each do |grandchild_node|
    generate_children(grandchild_node)
  end
end
