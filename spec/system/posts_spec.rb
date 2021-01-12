require 'rails_helper'

describe '投稿管理機能',type: :system do
  describe '一覧表示' do
    before do
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
      FactoryBot.create(:post, name: '最初の投稿',user: user_a)
    end
    context 'ログインしている時' do
      before do
        visit user_session_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'Login'
      end
      it 'ログインユーザーの作成した投稿が表示される' do
        visit posts_path
        expect(page).to have_content '最初の投稿'
      end
    end
  end
end