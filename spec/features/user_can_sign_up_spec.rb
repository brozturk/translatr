require 'spec_helper'

feature 'User can sign up' do 
  scenario 'with valid information' do
    visit new_user_path
    expect{
      fill_in 'İsim', with: 'Burak'
      fill_in 'Soy İsim', with: 'Ozturk'
      fill_in 'Mail Adresi', with: 'burak@burak.com'
      fill_in 'Şifre', with: '123456'
      fill_in 'Şifre Tekrar', with: '123456'
      click_button 'Beni Kaydet!'
    }.to change(User, :count).by(1)
  end
end
