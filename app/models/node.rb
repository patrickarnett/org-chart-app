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
  validate :parent_is_not_a_descendant, if: -> { parent_id_changed? && parent.present? }

  has_many :children, class_name: "Node", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Node", optional: true

  def name
    [first_name, last_name].select(&:present?).join(' ')
  end

  protected

  def ancestors
    ancestor = self
    ancestors = []
    until (ancestor = ancestor.parent).blank? || ancestors.include?(ancestor)
      ancestors << ancestor
    end
    ancestors
  end

  private

  def parent_is_not_a_descendant
    return unless parent.ancestors.include? self

    errors.add :parent, 'cannot be a descendant node'
  end
end
