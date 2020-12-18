# == Schema Information
#
# Table name: nodes
#
#  id         :integer          not null, primary key
#  first_name :text
#  job_title  :text
#  last_name  :text
#  root       :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :integer
#
# Indexes
#
#  index_nodes_on_parent_id  (parent_id)
#
class Node < ApplicationRecord
  validates :parent, absence: true, if: :root?

  has_many :children, class_name: "Node", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Node", optional: true
end
