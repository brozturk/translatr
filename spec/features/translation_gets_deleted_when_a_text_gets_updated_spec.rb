require 'spec_helper'

feature 'A translation gets deleted' do

  background do 
      @user = FactoryGirl.create(:user, translator: true, leader: false)
      @other_user = FactoryGirl.create(:user)
      @team = FactoryGirl.create(:team)
      @team.leader_id = @user.id
      relationship = FactoryGirl.create(:user_team, user_id: @user.id, team_id: @team.id, state: 'accepted')
      relationship2 = FactoryGirl.create(:user_team, user_id: @other_user.id, team_id: @team.id, state: 'accepted')
      @text = FactoryGirl.create(:text, user_id: @other_user.id, team_id: @team.id)
      @translation = FactoryGirl.create(:translation, text_id: @text.id, user_id: @user.id, team_id: @team.id)
  end
  
  scenario 'when a text gets deleted' do
    visit new_session_path
    fill_in 'Mail Adresi', with: @other_user.email
    fill_in 'Şifre', with: @other_user.password
    click_button 'Giriş'
    visit team_texts_path(@team)
    click_link @text.title
    click_link 'Yazıyı Sil'
    visit team_texts_path(@team)
    expect(page).not_to have_content @text.title
  end
end
