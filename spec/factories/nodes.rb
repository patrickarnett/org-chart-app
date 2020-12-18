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
FactoryBot.define do
  factory :node do
    job_title { FFaker::Job.title }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }

    trait :root do
      root { true }
    end
  end
end
