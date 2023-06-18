require 'rails_helper'

RSpec.describe 'ContactsControllers', type: :system do
  let(:contact) { create(:contact) }

  context 'お問い合わせ作成ページから確認ページに遷移できることについて' do
    scenario 'お問い合わせが作成できること' do
      visit new_contact_path
      fill_in 'contact[name]',	with: 'contact'
      fill_in 'contact[email]', with: 'example@example.com'
      fill_in 'contact[content]', with: 'テストですよ'
      click_button 'commit'
      expect(current_path).to eq confirm_path
    end

    scenario '不備があるとエラーが表示されること' do
      visit new_contact_path
      fill_in 'contact[name]',	with: 'contact'
      fill_in 'contact[email]', with: 'example'
      fill_in 'contact[content]', with: 'テストですよ'
      click_button 'commit'
      expect(current_path).to eq confirm_path
      expect(page).to have_content 'メールアドレスは不正な値です'
    end
  end

  context '確認ページについて' do
    before do
      visit new_contact_path
      fill_in 'contact[name]',	with: contact.name
      fill_in 'contact[email]', with: contact.email
      fill_in 'contact[content]', with: contact.content
      click_button 'commit'
    end

    scenario '確認ページに作成ページの情報が渡せていること' do
      expect(current_path).to eq confirm_path
      expect(page).to have_content contact.name
      expect(page).to have_content contact.email
      expect(page).to have_content contact.content
    end

    scenario '「送信」を押すとメールが送信できること' do
      click_button '送信'
      expect(current_path).to eq root_path
      expect(page).to have_content 'お問い合わせ内容を送信しました'
    end

    scenario '入力画面に戻るを押すと作成ページに戻れること' do
      click_button '入力画面に戻る'
      expect(current_path).to eq back_path
      expect(page).to have_field('contact[name]', with: contact.name)
      expect(page).to have_field('contact[email]', with: contact.email)
      expect(page).to have_field('contact[content]', with: contact.content)
    end
  end
end
