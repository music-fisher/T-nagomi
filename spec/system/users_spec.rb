require 'rails_helper'

describe 'User管理機能', type: :system do
  let(:user){FactoryBot.create(:user)}

  it 'ログインができる' do
    visit user_session_path
    fill_in 'Email',with: user.email
    fill_in 'Password',with: user.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end