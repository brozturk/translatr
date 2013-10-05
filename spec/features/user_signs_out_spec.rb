require 'spec_helper'

feature 'User signs out' do 
  scenario 'after login' do 
    create_user_and_login
    click_link 'Çıkış Yap'
    expect(page).to_not have_content @user.email
    expect(current_path).to eq root_path
  end
end
