require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:admin) { FactoryBot.create(:admin) }
  let(:admin2) { FactoryBot.create(:admin, project_id: 222_222, email: '1@example.com') }
  let(:category) { FactoryBot.create(:category, admin:) }
  let(:content) { FactoryBot.create(:content, admin:, category:) }

  context 'バリデーションについて' do
    it 'タイトル、説明文が規定文字数の場合、有効であること' do
      expect(category).to be_valid
    end

    it 'タイトルがない場合無効であること' do
      category.title = nil
      expect(category).not_to be_valid
    end

    it 'タイトルが空白の場合無効であること' do
      category.title = ''
      expect(category).not_to be_valid
    end

    it '説明文がない場合無効であること' do
      category.description = nil
      expect(category).not_to be_valid
    end

    it '説明文が空白の場合無効であること' do
      category.description = ''
      expect(category).not_to be_valid
    end

    it 'タイトルが規定の文字数ではない場合無効であること' do
      category.title = 'a' * 21
      expect(category).not_to be_valid
    end

    it '説明文が規定の文字数ではない場合無効であること' do
      category.description = 'a' * 31
      expect(category).not_to be_valid
    end

    it 'タイトルが重複してる場合、無効であること' do
      category2 = FactoryBot.build(:category, title: category.title, admin: admin)
      expect(category2).not_to be_valid
    end

    it '説明文が重複してる場合、無効であること' do
      category2 = FactoryBot.build(:category, description: category.description, admin: admin)
      expect(category2).not_to be_valid
    end
  end

  context 'リレーションについて' do
    it 'adminモデルとcategoryモデルのproject_idが一致すること' do
      expect(category.project_id).to eq admin.project_id
    end

    it '異なるproject_idを持つadminが同じタイトルのカテゴリーを作成できること' do
      category1 = FactoryBot.create(:category, admin:)
      category2 = FactoryBot.build(:category, title: category1.title, admin: admin2)
      expect(category2).to be_valid
    end

    it '異なるproject_idを持つadminが同じ説明のカテゴリーを作成できること' do
      category1 = FactoryBot.create(:category, admin:)
      category2 = FactoryBot.build(:category, description: category1.description, admin: admin2)
      expect(category2).to be_valid
    end

    it 'categoryを削除すると、関連するcontentも削除されること' do
      content
      expect { category.destroy }.to change(Content, :count).by(-1)
    end

    it 'categoryを削除するとき、project_idが異なるcategoryは削除されない' do
      category2 = FactoryBot.create(:category, admin: admin2)
      category.destroy
      expect(Category.exists?(category2.id)).to eq true
    end
  end
end
