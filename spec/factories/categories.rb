FactoryBot.define do
  factory :category do
    title { 'title' }
    description { 'description' }
    admin
    project_id { admin.project_id }
  end
end
