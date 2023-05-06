FactoryBot.define do
  factory :category do
    title { 'title' }
    description { 'description'}
    admin
    project_id {admin.project_id}
  end

  factory :category2 do
    title { 'title1' }
    description { 'description1'}
    project_id { '111111' }
    admin_id {'1'}
  end
end
