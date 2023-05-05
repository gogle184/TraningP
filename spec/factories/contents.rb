FactoryBot.define do
  factory :content do
    sequence(:title, "title_1")
    sequence(:description, "description_1")
    admin
    category
    category_id {category.id}
    project_id {admin.project_id}
    text {'テスト文章だよ'}
  end
end
