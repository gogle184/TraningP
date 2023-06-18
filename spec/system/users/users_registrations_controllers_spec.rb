require 'rails_helper'

RSpec.describe 'Users::RegistrationsControllers', type: :system do
  let(:user) { create(:user) }

  context '新規登録について' do
    scenario 'user(利用者)が新規登録できること' do
      visit new_user_registration_path
      fill_in 'user[email]', with: 'example@example.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      fill_in 'user[project_id]', with: 'admin1'
      click_button 'アカウントを作成する'
      expect(current_path).to eq contents_path
      expect(page).to have_content 'アカウント登録が完了しました'
    end

    scenario '不備があると新規登録ができないこと' do
      visit new_user_registration_path
      fill_in 'user[email]', with: 'example@example.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: ''
      fill_in 'user[project_id]', with: 'admin1'
      click_button 'アカウントを作成する'
      expect(current_path).to eq user_registration_path
      expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
    end
  end

  context 'ログイン機能について' do
    scenario 'ログインに成功すること' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      expect(current_path).to eq contents_path
      expect(page).to have_content 'ログインしました'
    end

    scenario 'ログインに失敗すること' do
      visit new_user_session_path
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      click_button 'ログイン'
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content 'メールアドレスまたはパスワードが違います'
    end
  end

  context 'user(利用者)情報編集について' do
    scenario 'user(利用者)が情報を編集できること' do
      login_as(user, scope: :user)
      visit edit_user_registration_path(user.id)
      fill_in 'user[email]', with: 'example@example.com'
      fill_in 'user[project_id]', with: '222222'
      fill_in 'user[current_password]', with: 'password'
      click_button '変更を保存する'
      expect(current_path).to eq root_path
      expect(page).to have_content 'アカウント情報を変更しました'
    end

    scenario '現在のパスワードが不足すると編集できないこと' do
      login_as(user, scope: :user)
      visit edit_user_registration_path(user.id)
      fill_in 'user[email]', with: 'example@example.com'
      fill_in 'user[project_id]', with: '111111'
      fill_in 'user[current_password]', with: ''
      click_button '変更を保存する'
      expect(current_path).to eq user_registration_path
      expect(page).to have_content '現在のパスワードを入力してください'
    end
  end
end
