require 'spec_helper'

feature 'user logs in' do 
  scenario 'with valid information' do 
    create_user_and_login
    expect(page).to have_content 'Başarılı bir şekilde giriş yapıldı!'
    expect(current_path).to eq user_path(@user)
    expect(page).to have_content @user.email
  end

  scenario 'with remember_me box checked' do 
    visit root_path
    fill_in_form 
    check('Beni Hatırla!')
    click_button 'Giriş'
    expect(page).to have_content 'Başarılı bir şekilde giriş yapıldı!'
    expect(current_path).to eq user_path(@user) 
    expect(page).to have_content @user.email
  end

  scenario 'with invalid information' do 
    login_with_invalid_info
    expect(page).to have_content 'Giriş sırasında sorun oluştu lütfen bilgilerin doğruluğunu kontrol et' 
    expect(current_path).to eq root_path 
    expect(page).to_not have_content @user.email
  end

  scenario 'user can click signup link and go to that page' do
    visit root_path
    click_link 'Kayıt ol!'
    expect(page).to have_content 'Hesap Oluştur'
    expect(current_path).to eq new_user_path 
  end
end
