require 'rails_helper'

RSpec.describe "ContentsControllers", type: :system do
    let(:admin) {create(:admin)}
    let(:user) {create(:user)}
    let(:category) {create(:category)}
    let(:content) {create(:content)}

    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
    end

    context 'コンテンツの新規作成について' do
      scenario 'カテゴリーの新規作成ができること' do
        visit new_content_path
        fill_in 'content[title]', with: 'testだよ'
        select category.title, from: 'content[category_id]'
        fill_in 'content[description]', with: 'testの説明'
        fill_in 'content[video]', with: ''
        fill_in 'content[youtube_url]', with: 'testだよ'
        fill_in 'content[text]', with: 'testの本文だよ'
        click_button '登録する'
        expect(current_path).to eq contents_path
        expect(page).to have_content '新規作成に成功しました'
        expect(page).to have_content 'testの説明'
        expect(page).to have_content 'testだよ'
      end
    end
end
