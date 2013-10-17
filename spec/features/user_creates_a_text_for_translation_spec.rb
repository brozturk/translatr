require 'spec_helper'

feature 'user creates a text for translation' do 
  background do 
    @team_leader = create(:user)
    @user = create(:user)
    @team = create(:team)
    @team.leader_id = @team_leader.id
    @team_leader.leader_of_team = @team.id
    @team_leader.leader = true
    @relationship = create(:user_team, user_id: @user.id, team_id: @team.id, state: 'accepted')
    visit new_session_path
    fill_in 'Mail Adresi', with: @team_leader.email
    fill_in 'Şifre', with: @team_leader.password
    click_button 'Giriş'
    visit new_text_path
    fill_in 'Başlık', with: 'a title' 
    fill_in 'Çevrilecekler', with: 'a text to be translated'  
    click_button 'Gönder'
    visit user_path(@team_leader)
    click_link 'Çıkış Yap'
  end

  scenario 'team members can view it' do 
    visit new_session_path
    fill_in 'Mail Adresi', with: @user.email
    fill_in 'Şifre', with: @user.password
    click_button 'Giriş'
    visit user_path(@user)
    click_button 'Çeviri Bekleyenler'
    expect(page).to have_content 'a title'
    expect(page).to have_content 'a text to be translated'
  end
end
