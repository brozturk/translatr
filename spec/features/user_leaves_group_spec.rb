require 'spec_helper'

feature 'user leaves group' do 
  background do 
    @user = create(:user, leader: true)
    @other_user = create(:user)
    @team = create(:team, leader_id: @user.id)
    relationship = create(:user_team, user_id: @user.id, team_id: @team.id, state: 'accepted')
    @relationship2 = create(:user_team, user_id: @other_user.id, team_id: @team.id, state: 'accepted')
    @other_team = create(:team)
  end

  scenario 'by clicking the leave team button' do 
    visit new_session_path
    fill_in 'Mail Adresi', with: @other_user.email
    fill_in 'Şifre', with: @other_user.password
    click_button 'Giriş'
    visit team_texts_path(@team)
    click_link 'Gruptan Çık'
    expect(current_path).to eq edit_user_team_path(@relationship2)
    click_link 'Gruptan Çık'
    visit team_texts_path(@team)
    expect(page).to have_content 'Bunu yapmaya izniniz yok'
    expect(current_path).to eq user_path(@other_user)
  end
end
