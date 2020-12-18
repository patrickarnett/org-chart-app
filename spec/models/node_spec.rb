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
  describe 'parent' do
    context 'when root' do
      let(:root_node) { create :node, :root }
      let(:other_node) { create :node }

      it 'is blank' do
        expect { root_node.parent = other_node }.to change(root_node, :valid?).to false
      end
    end
  end
end
