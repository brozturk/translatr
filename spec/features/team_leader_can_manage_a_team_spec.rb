require 'spec_helper'

feature 'Team leader can manage a team' do 

    before do 
      @user = FactoryGirl.create(:user, leader: true)
      @other_user = FactoryGirl.create(:user)
      @team = FactoryGirl.create(:team, leader_id: @user.id)
      @user.leader_of_team = @user.id
      relationship = FactoryGirl.create(:user_team, user_id: @user.id, team_id: @team.id, state: 'accepted')
      relationship2 = FactoryGirl.create(:user_team, user_id: @other_user.id, team_id: @team.id, state: 'accepted')
      @other_team = FactoryGirl.create(:team)
    end

  scenario 'by kicking users of a team' do 
    visit new_session_path
    fill_in 'Mail Adresi', with: @user.email
    fill_in 'Şifre', with: @user.password
    click_button 'Giriş'
    visit team_texts_path(@team)
    click_link 'Grubu Yönet'
    expect(current_path).to eq team_path(@team)
    expect(page).to have_content @other_user.name
    expect(page).to have_content @other_user.email
    click_link 'Gruptan At'
    expect(current_path).to eq team_path(@team)
    expect(page).not_to have_content @other_user.email
  end
end
