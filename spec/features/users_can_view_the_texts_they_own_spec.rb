require 'spec_helper' 

feature 'users can view the texts they on' do
  background do 
    @team_leader = create(:user, leader: true)
    @user = create(:user)
    @team = create(:team, leader_id: @team_leader.id)
    @relationship = create(:user_team, user_id: @user.id, team_id: @team.id, state: 'accepted')
    @leader_relationship = create(:user_team, user_id: @team_leader.id, team_id: @team.id, state: 'accepted')
    @users_text = create(:text, user_id: @user.id, team_id: @team.id)
    @leaders_text = create(:text, user_id: @team_leader.id, team_id: @team.id)
  end

  scenario 'by clicking on a link in the team page' do
    visit new_session_path
    fill_in 'Mail Adresi', with: @user.email
    fill_in 'Şifre', with: @user.password
    click_button 'Giriş'
    visit team_texts_path(@team)
    expect(page).to have_content 'Benim Çevirilerim'
    visit personal_team_texts_path(@team)
    expect(page).to have_content @users_text.title
    expect(page).not_to have_content @leaders_text.title
  end
end
