require 'spec_helper'

  feature 'User sees a list of users and translators' do
  background do 
    @user = create(:user, leader: true)
    @user2 = create(:user)
    @translator = create(:user, translator: true)
    @team = create(:team, name: 'Decoy Group', leader_id: @user.id)
    @relationship = create(:user_team, team_id: @team.id, user_id: @user.id, state: 'accepted')
  end
    scenario 'and sees translators by clicking on a tab' do 
    visit new_session_path
    fill_in 'Mail Adresi', with: @user.email
    fill_in 'Şifre', with: @user.password
    click_button 'Giriş'
    visit team_users_path(@team)
    expect(page).to have_content @translator.name
    expect(page).to have_content @user2.name
  end
end
