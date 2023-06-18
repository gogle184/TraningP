require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:contact) { FactoryBot.create(:contact) }

  context 'バリデーションについて' do
    it 'email、名前、本文がある場合、有効であること' do
      expect(contact).to be_valid
    end

    it 'emailが空白の場合、無効であること' do
      contact.email = ''
      expect(contact).not_to be_valid
    end

    it 'emailがnilの場合、無効であること' do
      contact.email = nil
      expect(contact).not_to be_valid
    end

    it '名前が空白の場合、無効であること' do
      contact.name = ''
      expect(contact).not_to be_valid
    end

    it '名前がnilの場合、無効であること' do
      contact.name = nil
      expect(contact).not_to be_valid
    end

    it '本文が空白の場合、無効であること' do
      contact.content = ''
      expect(contact).not_to be_valid
    end

    it '本文がnilの場合、無効であること' do
      contact.content = nil
      expect(contact).not_to be_valid
    end

    it 'emailが不正な場合、無効であること' do
      contact.email = '1111111111111'
      expect(contact).not_to be_valid
    end

    it '名前が規定の文字数以上の場合は無効であること' do
      contact.name = 'a' * 11
      expect(contact).not_to be_valid
    end

    it '本文が規定の文字数以上の場合は無効であること' do
      contact.content = 'a' * 301
      expect(contact).not_to be_valid
    end
  end
end
