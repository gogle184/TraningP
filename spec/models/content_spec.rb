require 'rails_helper'

RSpec.describe Content, type: :model do
  let(:admin) { FactoryBot.create(:admin) }
  let(:category) { FactoryBot.create(:category, admin:) }
  let(:content) { FactoryBot.create(:content, admin:, category:) }

  context 'バリデーションに関して' do
    it 'タイトル、説明文、カテゴリーID、project_id、本文がある場合、有効であること' do
      expect(content).to be_valid
    end

    it 'タイトルが空欄の場合、無効であること' do
      content.title = ''
      expect(content).not_to be_valid
    end

    it 'タイトルがnilの場合、無効であること' do
      content.title = nil
      expect(content).not_to be_valid
    end

    it 'タイトルが重複してる場合、無効であること' do
      content2 = FactoryBot.build(:content, title: content.title, admin: admin)
      expect(content2).not_to be_valid
    end

    it '説明文が空欄の場合、無効であること' do
      content.description = ''
      expect(content).not_to be_valid
    end

    it '説明文がnilの場合、無効であること' do
      content.description = nil
      expect(content).not_to be_valid
    end

    it '説明文が重複してる場合、無効であること' do
      content2 = FactoryBot.build(:content, description: content.description, admin: admin)
      expect(content2).not_to be_valid
    end

    it 'カテゴリーIDが空欄の場合、無効であること' do
      content.category_id = ''
      expect(content).not_to be_valid
    end

    it 'カテゴリーIDがnilの場合、無効であること' do
      content.category_id = nil
      expect(content).not_to be_valid
    end

    it 'project_idが空欄の場合、無効であること' do
      content.project_id = ''
      expect(content).not_to be_valid
    end

    it 'project_idがnilの場合、無効であること' do
      content.project_id = ''
      expect(content).not_to be_valid
    end

    it '本文が空欄の場合、無効であること' do
      content.text = ''
      expect(content).not_to be_valid
    end

    it '本文がnilの場合、無効であること' do
      content.text = nil
      expect(content).not_to be_valid
    end
  end

  context 'リレーションに関して' do
    it 'adminとの関連付けはbelongs_toである' do
      expect(Content.reflect_on_association(:admin).macro).to eq :belongs_to
    end

    it 'categoryとの関連付けはbelongs_toである' do
      expect(Content.reflect_on_association(:category).macro).to eq :belongs_to
    end
  end

  context 'アップロード機能に関して' do
    it '画像アップロードが有効であること' do
      image_path = Rails.root.join('spec', 'fixtures', 'images', 'test.jpg')
      file = Rack::Test::UploadedFile.new(image_path, 'image/jpeg')
      content.image = file
      expect(content.save).to be true
      expect(content.image.url).to include('test.jpg')
    end

    it '動画をアップロードできること' do
      video_path = Rails.root.join('spec', 'fixtures', 'videos', 'test.mov')
      file = Rack::Test::UploadedFile.new(video_path, 'video/mov')
      content.video = file
      expect(content.save).to be true
      expect(content.video.url).to include('test.mov')
    end
  end

  context 'has_rich_textに関して' do
    it '作成されたtext属性が有効であること' do
      expect(content.text).to be_present
    end
  end
end
