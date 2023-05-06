require 'rails_helper'

RSpec.describe "AdminsControllers", type: :system do

  let(:admin) {create(:admin)}

  context 'admin(管理者)の詳細が見れること' do
    scenario '詳細ページに情報があること' do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
      expect(current_path).to eq root_path
      expect(page).to have_content 'ログインしました'
      click_link 'Profile'
      expect(current_path).to eq admin_path(admin)
      expect(page).to have_content(admin.email)
      expect(page).to have_content(admin.project_id)
      expect(page).to have_content 'アカウントを編集する'
    end
  end
end
