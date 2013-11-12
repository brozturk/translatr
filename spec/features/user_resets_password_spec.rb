require 'spec_helper'

feature 'user resets password' do 

  scenario 'by clicking the password reset link' do 
    user = create(:user)
    visit new_session_path
    click_link 'Hatırlatalım!'
    fill_in 'Mail Adresi', with: user.email
    click_button 'Şifremi Hatırlat!'
    expect(current_path).to eq root_path
    expect(page).to have_content 'Şifrenizi yenilemeniz için göderdiğimiz maildeki linke tıklamanız gerekiyor'
    expect(open_last_email).to have_body_text (/Şifrenizi yenilemek için linke tıklayın/)
    expect(open_last_email).to be_delivered_to user.email
  end

  scenario 'by resetting password when they are logged in' do 
    user = create(:user)
    visit new_session_path
    fill_in 'Mail Adresi', with: user.email
    fill_in 'Şifre', with: user.password
    click_button 'Giriş'
    visit user_path(user)
    click_link 'Şifre Değiştir'
    fill_in 'Şifre', with: 'newpassword'
    fill_in 'Şifre Tekrar', with: 'newpassword'
    click_button 'Şifremi Değiştir'
    expect(page).to have_content 'Şifre başarılı bir şekilde değiştirildi'
    expect(current_path).to eq user_path(user)
    click_link 'Çıkış Yap'
    visit new_session_path
    fill_in 'Mail Adresi', with: user.email
    fill_in 'Şifre', with: 'newpassword'
    click_button 'Giriş'
    expect(page).to have_content user.email
  end
end
