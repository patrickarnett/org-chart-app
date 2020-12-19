require 'rails_helper'

describe 'Org chart', type: :feature, js: true do
  let!(:root_node) { create :node, :root }
  let!(:parent_node1) { create :node, parent: root_node }
  let!(:parent_node2) { create :node, parent: root_node }
  let!(:child_node) { create :node, parent: parent_node1 }

  it 'lists nodes' do
    visit root_path
    Node.all.each { |node| expect(page).to have_content node.name }
  end

  it 'reassigns node' do
    visit root_path
    parent1_li = find 'li', text: parent_node1.name
    parent2_li = find 'li', text: parent_node2.name
    expect(parent1_li).to have_content child_node.name
    expect(parent2_li).not_to have_content child_node.name

    within(parent1_li.find('li', text: child_node.name)) { click_link 'Edit' }
    expect(page).to have_content "Editing #{child_node.name}"
    select parent_node2.name, from: 'parent-node'
    click_button 'Save'

    expect(parent2_li).to have_content child_node.name
    expect(parent1_li).not_to have_content child_node.name
  end
end
