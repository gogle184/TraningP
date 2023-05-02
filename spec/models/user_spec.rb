require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー登録' do
    it "email、password、password_confirmation、admin_idが存在すれば登録できること" do
      user = build(:sato)
      expect(user).to be_valid
    end
  end
end
