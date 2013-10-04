require 'spec_helper'

feature 'user signs up' do 
  scenario 'with valid information' do 
    user = create(:user)
    visit root_path
    fill_in 'Mail Adresi', with: user.email 
    fill_in 'Şifre', with: user.password
    click_button 'Giriş'
    expect(page).to have_content 'Başarılı bir şekilde giriş yapıldı!'
    expect(current_path).to eq users_path(user)
  end
end
