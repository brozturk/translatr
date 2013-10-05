require 'spec_helper'

feature 'User can sign up' do 
  scenario 'with valid information' do
    visit new_user_path
    expect{
      fill_in 'İsim', with: 'burak'
      fill_in 'Soy İsim', with: 'ozturk'
      fill_in 'Mail Adresi', with: 'burak@burak.com'
      fill_in 'Şifre', with: '123456'
      fill_in 'Şifre Tekrar', with: '123456'
      click_button 'Beni Kaydet!'
    }.to change(User, :count).by(1) 
    expect(page).to have_content 'burak@burak.com'
  end

  scenario 'with invalid email' do  
    visit new_user_path
    expect{
      fill_in 'İsim', with: 'burak'
      fill_in 'Soy İsim', with: 'ozturk'
      fill_in 'Mail Adresi', with: 'bloblow'
      fill_in 'Şifre', with: '123456'
      fill_in 'Şifre Tekrar', with: '123456'
      click_button 'Beni Kaydet!'
    }.to_not change(User, :count).by(1) 
    expect(page).to have_content 'Girmiş olduğunuz bilgilerde hata var.Lütfen tekrar deneyin.'
    expect(current_path).to eq new_user_path 
    expect(page).to_not have_content 'burak@burak.com'
  end

  scenario 'with empty name field' do 
    visit new_user_path
    expect{
      fill_in 'İsim', with: ''
      fill_in 'Soy İsim', with: 'ozturk'
      fill_in 'Mail Adresi', with: 'burak@burak.com'
      fill_in 'Şifre', with: '123456'
      fill_in 'Şifre Tekrar', with: '123456'
      click_button 'Beni Kaydet!'
    }.to_not change(User, :count).by(1)
    expect(page).to have_content 'Girmiş olduğunuz bilgilerde hata var.Lütfen tekrar deneyin.'
    expect(current_path).to eq new_user_path  
    expect(page).to_not have_content 'burak@burak.com'
  end

  scenario 'when passwords mismatch' do 
    visit new_user_path
    expect{
      fill_in 'İsim', with: ''
      fill_in 'Soy İsim', with: 'ozturk'
      fill_in 'Mail Adresi', with: 'burak@burak.com'
      fill_in 'Şifre', with: '123456'
      fill_in 'Şifre Tekrar', with: '12345678'
      click_button 'Beni Kaydet!'
    }.to_not change(User, :count).by(1)
    expect(page).to have_content 'Girmiş olduğunuz bilgilerde hata var.Lütfen tekrar deneyin.'
    expect(current_path).to eq new_user_path 
    expect(page).to_not have_content 'burak@burak.com'
  end
end
