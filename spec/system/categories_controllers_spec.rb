require 'rails_helper'

RSpec.describe "CategoriesControllers", type: :system do

  let(:admin) {create(:admin)}
  let(:user) {create(:user)}
  let(:category) {create(:category, admin: admin)}
  let(:content) {create(:content, admin: admin)}

  context 'カテゴリーのアクセス制限について' do
    before  do
      visit root_path
    end

    scenario 'admin(管理者)であればアクセスできること' do
      login_as(admin, :scope => :admin)
      visit categories_path
      expect(current_path).to eq categories_path
      expect(page).to have_content 'カテゴリー名'
    end

    scenario 'admin(管理者)であれば、content作成画面から移行できること' do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
      click_link '研修作成'
      click_link 'ここ'
      expect(current_path).to eq categories_path
      expect(page).to have_content 'カテゴリー名'
    end

    scenario 'user(利用者)はアクセスできないこと' do
      login_as(user, :scope => :user)
      visit categories_path
      expect(current_path).to eq new_admin_session_path
      expect(page).to have_content 'ログインもしくはアカウント登録してください。'
    end

    scenario '非ログイン時はアクセスできないこと' do
      visit categories_path
      expect(current_path).to eq new_admin_session_path
      expect(page).to have_content 'ログインもしくはアカウント登録してください。'
    end
  end

  context 'カテゴリーの新規作成について' do
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
      visit root_path
    end

    scenario 'カテゴリーの新規作成ができること' do
      visit categories_path
      fill_in 'category[title]', with: 'testだよ'
      fill_in 'category[description]', with: 'testなんですよ'
      click_button '追加'
      expect(current_path).to eq categories_path
      expect(page).to have_content 'testだよ'
      expect(page).to have_content 'testなんですよ'
    end

    scenario '「カテゴリー名」「カテゴリー説明」の両方の入力がない時、追加ボタンを押せないこと' do
      visit categories_path
      fill_in 'category[title]', with: "カテゴリ失敗"
      fill_in 'category[description]', with: ""
      expect(page).to have_button("追加", disabled: true)
      fill_in 'category[description]', with: "テストテスト"
      expect(page).to have_button("追加", disabled: false)
    end

    scenario '同じカテゴリー名、説明は登録できないこと' do
      visit categories_path
      fill_in 'category[title]', with: 'title'
      fill_in 'category[description]', with: 'description'
      click_button '追加'
      fill_in 'category[title]', with: 'title'
      fill_in 'category[description]', with: 'description'
      click_button '追加'
      expect(page).to have_content 'エラーを確認してください'
      expect(page).to have_content 'タイトルはすでに存在します'
      expect(page).to have_content '説明はすでに存在します'
    end
  end

  context 'カテゴリーの編集、削除について' do
    before do
      login_as(admin, :scope => :admin)
      visit categories_path
      fill_in 'category[title]', with: '短くしたいな'
      fill_in 'category[description]', with: '短くしたいな'
      click_button '追加'
    end

    scenario 'カテゴリーが編集できること' do
      click_link '編集'
      fill_in 'category[title]', with: ''
      fill_in 'category[description]', with: ''
      fill_in 'category[title]', with: 'testだよ'
      fill_in 'category[description]', with: 'testなんですよ'
      click_button '更新する'
      expect(current_path).to eq categories_path
      expect(page).to have_content 'testだよ'
      expect(page).to have_content 'testなんですよ'
    end

    scenario 'カテゴリーが削除できること' do
      click_link '削除'
      page.accept_confirm
      expect(page).to have_content 'カテゴリーを削除しました'
      expect(page).not_to have_content 'testだよ'
    end
  end
end
