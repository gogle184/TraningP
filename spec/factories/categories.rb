FactoryBot.define do
  factory :category do
    sequence(:title) { |n| 'title#{n}'}
    sequence(:description) { |n| 'test#{n}'}
    admin
    project_id {admin.project_id}
  end
end
