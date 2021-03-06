require 'rails_helper'

describe 'User管理機能', type: :system do
 let!(:user_a){FactoryBot.build(:user, name: 'ユーザーA', email: 'a@example.com')}
 let!(:user_b){FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')}
 let!(:user){FactoryBot.create(:user)}
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
      context 'メールが重複している' do
        it '新規登録に失敗する' do
          visit new_user_registration_path
          fill_in 'user[email]',with: user.email
          fill_in 'user[password]',with: 'password'
          click_button '上記内容で登録する'
          expect(page).to have_content 'Eメールはすでに存在します'
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
      context 'パスワードが空白' do
        it 'ログインに失敗する' do
          visit user_session_path
          fill_in 'user[email]',with: user.email
          fill_in 'user[password]',with: ''
          click_button 'Log in'
          expect(current_path).to eq user_session_path
        end
      end
    end
  end
  describe 'ログイン後'do
    # モジュールに切り出したログインメソッド呼び出し
    before {login(user)}
    describe '編集機能'do
      context '入力値が正しい'do
        it 'ユーザ情報の編集に成功する'do
          visit edit_user_path(user)
          fill_in 'user[introduction]',with: 'よろしくお願いします！'
          click_button '変更を保存する'
          expect(page).to have_content 'プロフィールを編集しました。'
        end
      end
    end
  end
end