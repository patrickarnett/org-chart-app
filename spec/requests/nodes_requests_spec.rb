require 'rails_helper'

describe 'Nodes', type: :request do
  let!(:root_node) { create :node, :root }
  let!(:parent_node1) { create :node, parent: root_node }
  let!(:parent_node2) { create :node, parent: root_node }
  let!(:child_node) { create :node, parent: parent_node1 }

  describe 'index' do
    it 'is ok' do
      get nodes_path
      expect(response).to be_ok
    end
  end

  describe 'update' do
    let(:patch_update) do
      lambda do |node_id = nil|
        headers = { 'ACCEPT' => 'application/json' }
        patch node_path(node_id || child_node), params: { node: { parent_id: parent_node2.id } }, headers: headers
      end
    end

    it 'is ok' do
      patch_update.call
      expect(response).to be_ok
    end

    it 'updates parent' do
      expect { patch_update.call }.to change { child_node.reload.parent }.to parent_node2
    end

    it 'renders updated node' do
      patch_update.call
      expect(JSON.parse(response.body).sort).to eq child_node.reload.as_json.sort
    end

    context 'when unsuccessful' do
      it 'is ok' do
        patch_update.call root_node.id
        expect(response).to be_ok
      end

      it 'renders errors' do
        patch_update.call root_node.id
        expect(JSON.parse(response.body)).to include 'errors'
      end
    end

    context 'if node is not found' do
      it 'is not_found' do
        unused_id = Node.maximum(:id) + 1
        patch_update.call unused_id
        expect(response).to be_not_found
      end
    end
  end
end
