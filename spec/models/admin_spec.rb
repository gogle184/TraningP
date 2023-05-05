require 'rails_helper'

RSpec.describe Admin, type: :model do
  
  context 'バリデーションについて' do
    it 'email、パスワード、マネジメントIDがある場合、有効であること' do
      expect(FactoryBot.create(:admin)).to be_valid
    end

    it 'emailがない場合無効であること' do
      expect(FactoryBot.build(:admin, email: '')).to_not be_valid
    end

    it 'パスワードがない場合無効であること' do
      expect(FactoryBot.build(:admin, password: '')).to_not be_valid
    end

    it 'マネジメントIDがない場合無効であること' do
      expect(FactoryBot.build(:admin, project_id: '')).to_not be_valid
    end

    it 'emailが重複してる場合、無効であること' do
      admin1 = FactoryBot.create(:admin, email: 'testtesttest@example.com')
      expect(FactoryBot.build(:admin, email: admin1.email)).to_not be_valid
    end

    it 'マネジメントIDが重複している場合、無効であること' do
      admin1 = FactoryBot.create(:admin, project_id: 'testtest')
      expect(FactoryBot.build(:admin, project_id: admin1.project_id)).to_not be_valid
    end

    it 'マネジメントIDが指定の文字数ではない場合、無効であること' do
      expect(FactoryBot.build(:admin, project_id: '123')).to_not be_valid
    end

    it 'password_confirmationとpasswordが異なる場合保存できないこと' do 
      expect(FactoryBot.build(:admin, password: 'password', password_confirmation: 'passward')).to_not be_valid 
    end 
  end

  context 'パスワードについて' do
    it 'パスワードが暗号化されていること' do
      admin = FactoryBot.create(:admin)
      password = SecureRandom.hex(8)
      expect(admin.valid_password?(password)).to be_falsey
    end 
  end
end
