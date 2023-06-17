require 'rails_helper'

RSpec.describe "UsersControllers", type: :system do

  let(:user) {create(:user)}

  context 'user(利用者)の詳細が見れること' do
    scenario '詳細ページに情報があること' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      expect(current_path).to eq contents_path
      expect(page).to have_content 'ログインしました'
      click_link 'アカウント情報'
      expect(current_path).to eq user_path(user)
      expect(page).to have_content(user.email)
      expect(page).to have_content(user.project_id)
      expect(page).to have_content 'アカウントを編集する'
    end
  end
end
