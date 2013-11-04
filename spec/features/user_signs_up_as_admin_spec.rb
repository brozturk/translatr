require 'spec_helper'

feature 'user signs up as translator' do 
  scenario 'by checking the translator checkbox' do 
   visit new_user_path 
   fill_in 'İsim', with: 'Burak'
   fill_in 'Soy İsim', with: 'Ozturk'
   fill_in 'Mail Adresi', with: 'burak@burak.com'
   fill_in 'Şifre', with: '123456'
   fill_in 'Şifre Tekrar',  with: '123456'
   check 'Çevirmen Olarak Üye Ol'
   click_button 'Beni Kaydet!'
   expect(page).to have_content 'burak@burak.com'
  end
end
