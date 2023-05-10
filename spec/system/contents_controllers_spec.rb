require 'rails_helper'

RSpec.describe "ContentsControllers", type: :system,js: true do
    let(:admin) {create(:admin)}
    let(:user) {create(:user)}
    let!(:category) {create(:category, admin: admin ,title:'specテスト用')}
    let(:content) {create(:content, category: category, admin: admin)}

    before do
      login_as(admin)
    end

    context 'コンテンツの新規作成について' do
      scenario 'コンテンツの新規作成ができること' do
        visit new_content_path
        fill_in 'content[title]', with: 'testだよ'
        select category.title, from: 'content[category_id]'
        fill_in 'content[description]', with: 'testの説明'
        fill_in 'content[youtube_url]', with: 'testだよ'
        fill_in_rich_text_area '本文', with: 'テストだよん'
        click_button '登録する'
        expect(current_path).to eq contents_path
        expect(page).to have_content '新規作成に成功しました'
        expect(page).to have_content 'testの説明'
        expect(page).to have_content 'testだよ'
      end
    end
end
