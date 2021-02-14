module  LoginModule
def login(user)
    visit user_session_path
    fill_in 'user[email]',with: user.email
    fill_in 'user[password]',with: user.password
    click_button 'Log in'
end
end