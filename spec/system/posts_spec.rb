require 'rails_helper'

describe '投稿管理機能',type: :system do
  # 共通化
  # let(:user_a){FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')}
  # let(:user_b){FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')}
  # let!(:post_a){FactoryBot.create(:post, title: '最初の投稿',body: 'テスト投稿本文', user: user_a)}

  describe '一覧表示' do
      before do
        user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
        FactoryBot.create(:post, title: '最初の投稿', user: user_a)
      end
    context 'ログインしている時' do
      before do
        visit user_session_path
        fill_in 'メールアドレス', with: 'a@example.email'
        fill_in 'パスワード', with: 'password'
        click_button 'Log in'
        # let(:login_user){user_a}
        visit posts_path
      end
      it 'ログインユーザーの作成した投稿が表示される' do
        expect(page).to have_content '最初の投稿'
      end
    end
  end

  #   describe '詳細表示機能' do
  #     before do
  #       user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
  #       FactoryBot.create(:post, title: '最初の投稿', user: user_a)
  #     end
  #     context 'ユーザーAがログインしている時' do
  #     before do
  #       visit user_session_path
  #       fill_in 'メールアドレス', with: 'a@example.email'
  #       fill_in 'パスワード', with: 'password'
  #       click_button 'Log in'
  #       visit post_path(user_a.post)
  #     end
  #     it'ユーザーが作成した投稿が表示される'do
  #       expect(page).to heve_content '最初の投稿'
  #     end
  #   end
  # end
end