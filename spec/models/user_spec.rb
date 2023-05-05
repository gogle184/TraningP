require 'rails_helper'

RSpec.describe User, type: :model do
  
  context 'バリデーションについて' do
    it 'email、パスワード、マネジメントIDがある場合、有効であること' do
      expect(FactoryBot.create(:user)).to be_valid
    end

    it 'emailがない場合無効であること' do
      expect(FactoryBot.build(:user, email: '')).to_not be_valid
    end

    it 'パスワードがない場合無効であること' do
      expect(FactoryBot.build(:user, password: '')).to_not be_valid
    end

    it 'マネジメントIDがない場合無効であること' do
      expect(FactoryBot.build(:user, project_id: '')).to_not be_valid
    end

    it 'emailが重複してる場合、無効であること' do
      admin1 = FactoryBot.create(:user, email: 'testtesttest@example.com')
      expect(FactoryBot.build(:user, email: admin1.email)).to_not be_valid
    end

    it 'マネジメントIDが指定の文字数ではない場合、無効であること' do
      expect(FactoryBot.build(:user, project_id: '123')).to_not be_valid
    end

    it 'password_confirmationとpasswordが異なる場合保存できないこと' do 
      expect(FactoryBot.build(:user, password: 'password', password_confirmation: 'passward')).to_not be_valid 
    end 
  end

  context 'パスワードについて' do
    it 'パスワードが暗号化されていること' do
      user = FactoryBot.create(:user)
      password = SecureRandom.hex(8)
      expect(user.valid_password?(password)).to be_falsey
    end 
  end

  context 'adminモデルとの関係について' do
    let(:admin) { FactoryBot.create(:admin, project_id: 'test_pro') }
    let(:user) { FactoryBot.build(:user, project_id: admin.project_id) }
  
    it 'userモデルのマネジメントIDがadminモデルのマネジメントIDと同じでも有効であること' do
      expect(user).to be_valid
    end
  
    it 'userモデル間でマネジメントIDが同じでも有効であること' do
      FactoryBot.create(:user, email: 'test@example.com', project_id: admin.project_id)
      expect(user).to be_valid
    end
  end
end
