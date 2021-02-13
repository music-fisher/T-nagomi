require 'rails_helper'

describe '投稿管理機能',type: :system do
  # 共通化
  let(:user_a){FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')}
  # let(:user_b){FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')}
  let!(:post_a){FactoryBot.create(:post, title: '最初の投稿',body: 'テスト投稿本文', user: user_a)}
  before do
    visit user_session_path
    fill_in 'Email', with: user_a.email
    fill_in 'Password', with: user_a.password
    click_button 'Log in'
  end

  describe '一覧表示' do
    context 'ログインしている時' do
      before do
      #   visit user_session_path
      #   fill_in 'Email', with: user_a.email
      #   fill_in 'Password', with: user_a.password
      #   click_button 'Log in'
        visit posts_path
      end
      it 'ログインユーザーの作成した投稿が表示される' do
        expect(page).to have_content '最初の投稿'
      end
    end
  end

    describe '詳細表示機能' do
      context 'ユーザーAがログインしている時' do
      before do
        visit post_path(post_a)
      end
      it'ユーザーが作成した投稿が表示される'do
        expect(page).to have_content '最初の投稿'
      end
    end
  end
end