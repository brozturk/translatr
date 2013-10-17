require 'spec_helper'

feature 'user creates a text for translation' do 
  background do 
    @team_leader = create(:user, leader: true)
    @user = create(:user)
    @team = create(:team)
    @team.leader_id = @team_leader.id
    @team_leader.leader_of_team = @team.id
    @relationship = create(:user_team, user_id: @user.id, team_id: @team.id, state: 'accepted')
    visit new_session_path
    fill_in 'Mail Adresi', with: @team_leader.name
    fill_in 'Şifre', with: @team_leader.password
    visit new_text_path
    fill_in 'Başlık', with: 'a title' 
    fill_in 'Çevrilecekler', with: 'a text to be translated'  
  end

  scenario 'team members can view it' do 
    click_link 'Çıkış Yap'
    visit new_session_path
    fill_in 'Mail Adresi', with: @user.name
    fill_in 'Şifre', with: @user.password
    visit user_path(@user)
    click_button 'Çeviri Bekleyenler'
    expect(page).to have_content 'a title'
    expect(page).to have_content 'a text to be translated'
  end
end
