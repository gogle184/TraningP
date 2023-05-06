require 'rails_helper'

RSpec.describe "ApplicationControllers", type: :system do

  let(:admin) {create(:admin)}
  let(:user) {create(:user)}

  context 'ログインしてないヘッダーについて' do
    before do
      visit root_path
    end

    scenario '非ログイン時、ヘッダー情報が表示されていること' do
      expect(page).to have_content 'Home'
      expect(page).to have_content 'About'
      expect(page).to have_content 'ログインはこちら'
      expect(page).to have_content '管理者はこちら'
    end

    scenario 'HOMEをクリックするとHome画面に移動すること' do
      click_link 'Home'
      expect(current_path).to eq root_path
    end

    scenario '利用者(user)ログイン画面に遷移できること' do
      click_link 'ログインはこちら'
      expect(current_path).to eq new_user_session_path
    end

    scenario '管理者(admin)ログイン画面に遷移できること' do
      click_link '管理者はこちら'
      expect(current_path).to eq new_admin_session_path
    end
  end

  context '利用者(user)がログインしているヘッダーについて' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    scenario 'ログイン後、userのヘッダー情報が表示されていること' do
      expect(page).to have_content user.email 
      expect(page).to have_content 'Profile'
      expect(page).to have_content 'Logout'
    end

    scenario 'Profileをクリックすると、現在のuserの詳細ページが表示されること' do
      click_link 'Profile'
      expect(current_path).to eq user_path(user)
    end

    scenario 'Logoutをクリックするとログアウトされること' do
      click_link 'Logout'
      expect(current_path).to eq root_path
      expect(page).to have_content 'ログアウトしました。'
    end
  end

  context '管理者(admin)がログインしているヘッダーについて' do
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
    end

    scenario 'ログイン後、userのヘッダー情報が表示されていること' do
      expect(page).to have_content admin.email 
      expect(page).to have_content 'Profile'
      expect(page).to have_content 'Logout'
    end

    scenario 'Profileをクリックすると、現在のuserの詳細ページが表示されること' do
      click_link 'Profile'
      expect(current_path).to eq admin_path(admin)
    end

    scenario 'Logoutをクリックするとログアウトされること' do
      click_link 'Logout'
      expect(current_path).to eq root_path
      expect(page).to have_content 'ログアウトしました'
    end
  end

  context 'お問い合わせについて' do
    before do
      visit root_path
    end

    scenario '「こちら」を押すとお問い合わせフォームに飛べること' do
      click_link 'こちら'
      expect(current_path).to eq new_contact_path
    end
  end

  context 'authenticateメソッド(非ログイン時)について' do
    before do
      visit root_path
    end

    scenario 'user/showページに遷移しないこと' do
      visit user_path(user)
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content 'ログインもしくはアカウント登録してください。'
    end

    scenario 'admin/showページに遷移しないこと' do
      visit admin_path(admin)
      expect(current_path).to eq new_admin_session_path
      expect(page).to have_content 'ログインもしくはアカウント登録してください。'
    end

    scenario 'contents/indexに遷移しないこと' do
      visit contents_path
      expect(current_path).to eq root_path
      expect(page).to have_content 'ログインが必要です'
    end

    scenario 'categories/indexに遷移しないこと' do
      visit categories_path
      expect(current_path).to eq new_admin_session_path
      expect(page).to have_content 'ログインもしくはアカウント登録してください。'
    end
  end
end
