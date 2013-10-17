require 'spec_helper'

feature 'user creates a text for translation' do 
  background do 
    @team_leader = create(:user)
    @user = create(:user)
    @team = create(:team, leader_id: @team_leader.id)
    @relationship = create(:user_team, user_id: @user.id, team_id: @team.id, state: 'accepted')
    @text = create(:text, user_id: @user.id)
  end
  scenario 'only team members can view it' do 
  end
end
