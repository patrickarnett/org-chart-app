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
require 'rails_helper'

describe Node do
  let(:node) { create :node }

  describe 'name' do
    it 'is first and last name' do
      expect(node.name).to eq "#{node.first_name} #{node.last_name}"
    end
  end

  describe 'parent' do
    context 'when root' do
      let(:root_node) { create :node, :root }

      it 'is blank' do
        expect { root_node.parent = node }.to change(root_node, :valid?).to false
      end
    end

    it 'cannot be a descendant' do
      node1 = create :node
      node2 = create :node, parent: node1
      node3 = create :node, parent: node2

      expect { node1.parent = node3 }.to change(node1, :valid?).to false
    end
  end
end
