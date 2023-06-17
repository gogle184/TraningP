require 'rails_helper'

RSpec.describe "ApplicationControllers", type: :system do

  let(:admin) {create(:admin)}
  let(:user) {create(:user)}

  context 'ログインしてないヘッダーについて' do
    before do
      visit root_path
    end

    scenario '非ログイン時、ヘッダー情報が表示されていること' do
      expect(page).to have_content 'ホーム'
      expect(page).to have_content 'お問い合わせ'
      expect(page).to have_content 'ログインはこちら'
      expect(page).to have_content '管理者はこちら'
    end

    scenario 'HOMEをクリックするとHome画面に移動すること' do
      click_link 'ホーム'
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
      expect(page).to have_content 'アカウント情報'
      expect(page).to have_content 'ログアウト'
    end

    scenario 'アカウント情報をクリックすると、現在のuserの詳細ページが表示されること' do
      click_link 'アカウント情報'
      expect(current_path).to eq user_path(user)
    end

    scenario 'ログアウトをクリックするとログアウトされること' do
      click_link 'ログアウト'
      expect(current_path).to eq root_path
      expect(page).to have_content 'ログアウトしました。'
    end

    scenario 'お問い合わせをクリックするとフォームに飛ぶこと' do
      click_link 'お問い合わせ'
      expect(current_path).to eq new_contact_path
    end
  end

  context '管理者(admin)がログインしているヘッダーについて' do
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
    end

    scenario 'ログイン後、adminのヘッダー情報が表示されていること' do
      expect(page).to have_content admin.email 
      expect(page).to have_content 'アカウント情報'
      expect(page).to have_content 'ログアウト'
    end

    scenario 'Profileをクリックすると、現在のadminの詳細ページが表示されること' do
      click_link 'アカウント情報'
      expect(current_path).to eq admin_path(admin)
    end

    scenario 'ログアウトをクリックするとログアウトされること' do
      click_link 'ログアウト'
      expect(current_path).to eq root_path
      expect(page).to have_content 'ログアウトしました'
    end

    scenario 'お問い合わせをクリックするとフォームに飛ぶこと' do
      click_link 'お問い合わせ'
      expect(current_path).to eq new_contact_path
    end
  end

  context 'お問い合わせについて' do
    before do
      visit root_path
    end

    scenario '「こちら」を押すとお問い合わせフォームに飛べること' do
      click_link 'footer-link'
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
