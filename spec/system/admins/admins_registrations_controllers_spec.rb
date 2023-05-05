require 'rails_helper'

RSpec.describe "Admins::RegistrationsControllers", type: :system do
  before do
    @admin = create(:admin)
  end
  context '新規登録について' do
    scenario 'admin(管理者)が新規登録できること' do
      visit new_admin_registration_path
      fill_in 'admin[email]', with: 'new@example.com'
      fill_in 'admin[password]', with: 'password'
      fill_in 'admin[password_confirmation]', with: 'password'
      fill_in 'admin[project_id]', with: 'admin1'
      click_button 'アカウントを作成する'
    
      expect(current_path).to eq root_path
      expect(page).to have_content 'アカウント登録が完了しました'
    end

    scenario '不備があると新規登録ができないこと' do
      visit new_admin_registration_path
      fill_in 'admin[email]', with: 'new@example.com'
      fill_in 'admin[password]', with: 'password'
      fill_in 'admin[password_confirmation]', with: ''
      fill_in 'admin[project_id]', with: 'admin1'
      click_button 'アカウントを作成する'
    
      expect(current_path).to eq admin_registration_path
      expect(page).to have_content '保存されませんでした'
    end
  end

  context 'ログイン機能について' do
    scenario 'admin(管理者)が情報を編集できること' do
      login_as(@admin)
      visit edit_admin_registration_path
      fill_in 'admin[email]', with: 'new@example.com'
      fill_in 'admin[current_password]', with: 'password' 
      click_button '変更を保存する'
    
      expect(current_path).to eq root_path
      expect(page).to have_content 'アカウント情報を変更しました'
    end

    scenario '現在のパスワードが不足すると編集できないこと' do
      login_as(@admin)
      visit edit_admin_registration_path
      fill_in 'admin[email]', with: 'new@example.com'
      fill_in 'admin[current_password]', with: '' 
      click_button '変更を保存する'
    
      expect(current_path).to eq admin_registration_path
      expect(page).to have_content '保存されませんでした'
    end
  end
end
