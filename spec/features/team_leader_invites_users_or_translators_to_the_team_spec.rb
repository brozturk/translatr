require 'spec_helper'

feature 'team leader invites users or translators to the team' do 
  background do 
    @user2 = create(:user, translator: true)
    create_user_and_login
    visit user_path(@user)
    click_link 'Grup Oluştur'
    fill_in 'Grup İsmi', with: 'Decoy Group'
    click_button 'Grubu Kur' 
    click_link 'Gruba Ekle'
    within('form#translator') do 
      click_button 'Gruba Davet Et'
    end
  end

  scenario 'they recieve a request to join the team' do 
    click_link 'cikis yap'
    visit new_session_path
    fill_in 'Email', with: @user2.email
    fill_in 'Şifre', with: @user2.password
    click_button 'Giriş Yap'
    visit user_path(@user2)
    click_link 'Katılım İsteği'
    click_button 'Kabul Et'
    expect(page).to have_content 'Çeviri Yaptır'
    expect(page).to have_content 'Grup Üyeleri'
    expect(page).to have_content 'Decoy Group'
  end
end
