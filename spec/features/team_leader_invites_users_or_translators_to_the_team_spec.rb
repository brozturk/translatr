require 'spec_helper'

feature 'team leader invites users or translators to the team' do 
  background do 
    @user2 = create(:user, translator: true)
    @user = create(:user, leader: true)
    @team = create(:team, name: 'Decoy Group', leader_id: @user.id)
    @relationship = create(:user_team, team_id: @team.id, user_id: @user.id, state: 'accepted')
    visit new_session_path
    fill_in 'Mail Adresi', with: @user.email
    fill_in 'Şifre', with: @user.password
    click_button 'Giriş'
    visit team_texts_path(@team)
    expect(page).to have_content 'Gruba Ekle'
    visit team_users_path(@team)
    within('form#translator') do 
      click_button 'Gruba Davet Et'
    end
  end

  scenario 'they accept a request to join the team' do 
    sign_in_as_second_user_and_go_to_request_page
    click_button 'Kabul Et'
    expect(page).to have_content 'Decoy Group'
  end

  scenario 'they decline a request to join a team' do 
    sign_in_as_second_user_and_go_to_request_page
    click_button 'Reddet'
    expect(page).not_to have_content 'Grup Üyeleri'
    expect(page).not_to have_content 'Decoy Group'
  end
end


def sign_in_as_second_user_and_go_to_request_page
    click_link 'Çıkış Yap'
    visit new_session_path
    fill_in 'Mail Adresi', with: @user2.email
    fill_in 'Şifre', with: @user2.password
    click_button 'Giriş'
    visit user_path(@user2)
    expect(page).to have_content 'Katılım İsteği'
    visit user_teams_path
end
