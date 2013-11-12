require 'spec_helper'

feature 'user dashboard' do 
  background do
    @user = create(:user)
    @translator = create(:user, translator: true)
    @team = create(:team)
    @other_team = create(:team)
    user_realtionship = create(:user_team, user_id: @user.id, team_id: @team.id, state: 'accepted')
    user_realtionship2 = create(:user_team, user_id: @user.id, team_id: @other_team.id, state: 'accepted')
    translator_relationship = create(:user_team, user_id: @translator.id, team_id: @team.id, state: 'accepted')
    translator_relationship2 = create(:user_team, user_id: @translator.id, team_id: @other_team.id, state: 'accepted')
    @text = create(:text, user_id: @user.id, team_id: @team.id)
    @other_text = create(:text, user_id: @user.id, team_id: @other_team.id)
    @translated_text = create(:text, user_id: @user.id, team_id: @other_team.id)
    @translation = create(:translation, user_id: @translator.id, team_id: @other_team.id, text_id: @translated_text.id)
  end
  scenario 'user can see a list of their recent texts they posted' do
    visit new_session_path
    fill_in 'Mail Adresi', with: @user.email
    fill_in 'Şifre', with: @user.password
    click_button 'Giriş'
    visit user_path(@user)
    expect(page).to have_content @text.title
    expect(page).to have_content @other_text.title
    expect(page).to have_content @translated_text.title
  end

  scenario 'translators can see untranslated texts in teams they are a member of' do
    visit new_session_path
    fill_in 'Mail Adresi', with: @translator.email
    fill_in 'Şifre', with: @translator.password
    click_button 'Giriş'
    visit user_path(@translator)
    expect(page).to have_content @text.title
    expect(page).to have_content @other_text.title
    expect(page).not_to have_content @translated_text.title
  end
end
