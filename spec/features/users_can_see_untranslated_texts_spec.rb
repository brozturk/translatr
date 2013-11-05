require 'spec_helper'

feature 'users can see untranslated texts' do 
  background do 
    @team_leader = create(:user, leader: true)
    @translator = create(:user, translator: true)
    @user = create(:user)
    @team = create(:team, leader_id: @team_leader.id)
    @team_leader.leader_of_team = @team.id
    @relationship = create(:user_team, user_id: @user.id, team_id: @team.id, state: 'accepted')
    @translator_relationship = create(:user_team, user_id: @translator.id, team_id: @team.id, state: 'accepted')
    @leader_relationship = create(:user_team, user_id: @team_leader.id, team_id: @team.id, state: 'accepted')
    @users_text = create(:text, user_id: @user.id, team_id: @team.id)
    @leaders_text = create(:text, user_id: @team_leader.id, team_id: @team.id)
    @leaders_translation = create(:translation, user_id: @team_leader.id, team_id: @team.id, text_id: @leaders_text.id)
  end

  scenario 'as a team_leader' do 
    visit new_session_path
    fill_in 'Mail Adresi', with: @team_leader.email
    fill_in 'Şifre', with: @team_leader.password
    click_button 'Giriş'
    visit team_texts_path(@team)
    expect(page).to have_content 'Çevrilmemiş Metinler'
    visit team_translations_path(@team)
    expect(page).to have_content @users_text.title
    expect(page).not_to have_content @leaders_text.title
  end
end
