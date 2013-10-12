require 'spec_helper'

feature 'user creates a gorup' do 
  scenario 'from the create group link' do 
    create_user_and_login
    visit user_path(@user)
    click_link 'Grup Oluştur'
    fill_in 'Grup İsmi', with: 'blaloblawgrou'
    expect(page).to have_content 'Grup Yönet'
    expect(page).to have_content 'Gruba Ekle'
    expect (page).to have_content 'Grup İşlemleri'
  end
end

