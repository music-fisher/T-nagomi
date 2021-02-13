require 'rails_helper'

describe 'User管理機能', type: :system do
 let!(:user_a){FactoryBot.build(:user, name: 'ユーザーA', email: 'a@example.com')}
 #let(:user_b){FactoryBot.build(:user, name: 'ユーザーB', email: 'b@example.com')}
 let!(:user){FactoryBot.create(:user)}
  # before do
  #   visit user_session_path
  #   fill_in 'Email', with: user.email
  #   fill_in 'Password', with: user.password
  #   click_button 'Log in'
  # end
  describe 'ログイン前' do
    describe '新規登録機能'do
      context '入力値が正しい'do
        it '新規登録ができる'do
          visit new_user_registration_path
          fill_in 'user[name]',with: user_a.name
          fill_in 'user[email]', with: user_a.email
          fill_in 'user[password]',with: 'password'
          fill_in 'user[password_confirmation]',with: 'password'
          click_button '上記内容で登録する'
          expect(page).to have_content 'アカウント登録が完了しました。'
        end
      end
      context 'メールが空白'do
        it '新規登録に失敗する'do
          visit new_user_registration_path
          fill_in 'user[name]',with: user_a.name
          fill_in 'user[email]', with: ''
          fill_in 'user[password]',with: 'password'
          fill_in 'user[password_confirmation]',with: 'password'
          click_button '上記内容で登録する'
          expect(current_path).to eq '/users'
          expect(page).to have_content 'Eメールを入力してください'
        end
      end
    end
    describe 'ログイン機能'do
      context 'ログインの入力値が正しい'do
        it 'ログインが成功する' do
          visit user_session_path
          fill_in 'user[email]',with: user.email
          fill_in 'user[password]',with: 'password'
          click_button 'Log in'
          expect(page).to have_content 'ログインしました'
        end
      end
      context 'メールが重複している' do
        it 'ログインに失敗する' do
        end
      end
      context 'パスワードが空白' do
        it 'ログインに失敗する' do
        end
      end
    end
  end
  describe 'ログイン後'do
    describe '編集機能'do
      context '入力値が正しい'do
        it 'ユーザ情報の編集に成功する'do
        end
      end
    end
  end
end