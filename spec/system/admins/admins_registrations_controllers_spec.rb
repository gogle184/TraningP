require 'rails_helper'

RSpec.describe 'Admins::RegistrationsControllers', type: :system do
  let(:admin) { FactoryBot.create(:admin) }
  context '新規登録について' do
    scenario 'admin(管理者)が新規登録できること' do
      visit new_admin_registration_path
      fill_in 'admin[email]', with: 'newnew@example.com'
      fill_in 'admin[password]', with: 'password'
      fill_in 'admin[password_confirmation]', with: 'password'
      fill_in 'admin[project_id]', with: 'test123'
      click_button 'アカウントを作成する'

      expect(current_path).to eq contents_path
      expect(page).to have_content 'アカウント登録が完了しました'
    end

    scenario '不備があると新規登録ができないこと' do
      visit new_admin_registration_path
      fill_in 'admin[email]', with: 'newnew@example.com'
      fill_in 'admin[password]', with: 'password'
      fill_in 'admin[password_confirmation]', with: ''
      fill_in 'admin[project_id]', with: 'admin123'
      click_button 'アカウントを作成する'

      expect(current_path).to eq admin_registration_path
      expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
    end
  end

  context 'ログイン機能について' do
    before do
      visit root_path
    end

    scenario 'ログインに成功すること' do
      click_link '管理者はこちら'
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
      expect(current_path).to eq contents_path
      expect(page).to have_content 'ログインしました'
    end

    scenario 'ログインに失敗すること' do
      visit new_admin_session_path
      fill_in 'admin[email]', with: ''
      fill_in 'admin[password]', with: ''
      click_button 'ログイン'
      expect(current_path).to eq new_admin_session_path
      expect(page).to have_content 'メールアドレスまたはパスワードが違います'
    end
  end

  context 'admin(管理者)情報編集について' do
    scenario 'admin(管理者)が情報を編集できること' do
      login_as(admin)
      visit root_path
      click_link 'アカウント情報'
      click_link 'アカウントを編集する'
      fill_in 'admin[email]', with: 'gogo@example.com'
      fill_in 'admin[current_password]', with: 'password'
      click_button '変更を保存する'
      expect(current_path).to eq root_path
      expect(page).to have_content 'アカウント情報を変更しました'
    end

    scenario '現在のパスワードが不足すると編集できないこと' do
      login_as(admin)
      visit edit_admin_registration_path
      fill_in 'admin[email]', with: 'new@example.com'
      fill_in 'admin[current_password]', with: ''
      click_button '変更を保存する'

      expect(current_path).to eq admin_registration_path
      expect(page).to have_content '現在のパスワードを入力してください'
    end
  end
end

# bundle exec  rspec spec/system/admins/admins_registrations_controllers_spec.rb
