require 'rails_helper'

RSpec.describe 'ContentsControllers', type: :system, js: true do
  let(:admin) { create(:admin) }
  let!(:user) { create(:user, project_id: admin.project_id) }
  let!(:category) { create(:category, admin:, title: 'specテスト用', description: 'テストカテゴリ') }
  let!(:content) { create(:content, category:, admin:, title: 'テストコンテンツ', description: 'テスト用です') }

  describe 'admin(管理者)機能について' do
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

      scenario '不備があると新規作成できないこと' do
        visit new_content_path
        fill_in 'content[title]', with: ''
        # select category.title, from: 'content[category_id]'
        fill_in 'content[description]', with: ''
        fill_in 'content[youtube_url]', with: ''
        fill_in_rich_text_area '本文', with: ''
        click_button '登録する'
        expect(current_path).to eq contents_path
        expect(page).to have_content 'タイトルを入力してください'
        expect(page).to have_content 'タイトルは4文字以上で入力してください'
        expect(page).to have_content 'カテゴリーを入力してください'
        expect(page).to have_content '説明を入力してください'
        expect(page).to have_content '本文は必須項目です'
      end
    end

    context 'コンテンツの編集について' do
      scenario 'コンテンツの編集ができること' do
        visit contents_path
        visit edit_content_path(content)
        fill_in 'content[title]', with: 'testだよ'
        select category.title, from: 'content[category_id]'
        fill_in 'content[description]', with: 'testの説明'
        fill_in 'content[youtube_url]', with: 'testだよ'
        fill_in_rich_text_area '本文', with: 'テストだよん'
        click_button '更新する'
        expect(current_path).to eq contents_path
        expect(page).to have_content '編集内容を保存しました'
        expect(page).to have_content 'testの説明'
        expect(page).to have_content 'testだよ'
      end

      scenario '不備があると編集ができないこと' do
        visit contents_path
        visit edit_content_path(content)
        fill_in 'content[title]', with: ''
        select category.title, from: 'content[category_id]'
        fill_in 'content[description]', with: 'testの説明'
        fill_in 'content[youtube_url]', with: 'testだよ'
        fill_in_rich_text_area '本文', with: 'テストだよん'
        click_button '更新する'
        expect(current_path).to eq content_path(content.id)
        expect(page).to have_content 'タイトルを入力してください'
        expect(page).to have_content 'タイトルは4文字以上で入力してください'
      end
    end

    context 'コンテンツの削除について' do
      scenario 'コンテンツの削除ができること' do
        visit contents_path
        click_link content.title
        click_link '削除'
        page.accept_confirm
        expect(current_path).to eq contents_path
        expect(page).to have_content 'コンテンツを削除しました'
      end
    end
  end

  describe 'user(利用者)機能について' do
    before do
      login_as(user, scope: :user)
      visit root_path
    end

    context 'コンテンツの利用について' do
      scenario 'user(利用者)が閲覧できること' do
        visit contents_path
        expect(current_path).to eq contents_path
        expect(page).to have_content 'specテスト用'
        expect(page).to have_content 'テストカテゴリ'
        expect(page).to have_content 'テストコンテンツ'
        expect(page).to have_content 'テスト用です'
      end

      scenario '一覧に「編集」、「削除」のリンクが出ないこと' do
        click_link '研修一覧'
        expect(page).not_to have_content '編集'
        expect(page).not_to have_content '削除'
      end

      scenario '投稿詳細に「編集」、「削除」のリンクが出ないこと' do
        click_link '研修一覧'
        click_link content.title
        expect(page).not_to have_content '編集'
        expect(page).not_to have_content '削除'
      end

      scenario 'タイトルをクリックするとコンテンツ詳細にいけること' do
        click_link '研修一覧'
        click_link content.title
        expect(current_path).to eq content_path(content)
        expect(page).to have_content content.title
        expect(page).to have_content content.description
        expect(page).to have_content 'テスト文章だよ'
      end
    end
  end
end
