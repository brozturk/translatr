require 'spec_helper'

describe Permissions::TeamLeaderPermission do 
    let!(:user) { create(:user, leader: true) } 
    let!(:other_user) { create(:user) } 
    let!(:users_team) { create(:team, leader_id: user.id) } 
    let!(:relationship) { create(:user_team, user_id: user.id, team_id: users_team.id, state: 'accepted') } 
    let!(:relationship2) { create(:user_team, user_id: other_user.id, team_id: users_team.id, state: 'accepted') } 
    let!(:other_team) { create(:team) } 
    let!(:other_relationship) { create(:user_team, user_id: other_user.id, team_id: other_team.id, state: 'accepted') } 
    let!(:users_text) { create(:text, user_id: user.id, team_id: users_team.id) } 
    let!(:other_text) { create(:text, user_id: other_user.id,  team_id: users_team.id) } 
    let!(:other_team_text) { create(:text, user_id: other_user.id,  team_id: other_team.id) } 

    subject { Permissions.permission_for(user) } 

    it 'allows sessions' do 
      should allow_action(:sessions, :new) 
      should allow_action(:sessions, :create)  
      should allow_action(:sessions, :destroy) 
    end

    it 'allows users' do 
      should allow_action(:users, :new) 
      should allow_action(:users, :create) 
      should allow_action(:users, :index)  
      should allow_action(:users, :show) 
    end

    it 'allows user_teams' do 
      should allow_action(:user_teams, :index)  
      should allow_action(:user_teams, :create) 
      should allow_action(:user_teams, :update) 
      should allow_action(:user_teams, :destroy, relationship2) 
      should_not allow_action(:user_teams, :destroy, other_relationship) 
      should_not allow_action(:user_teams, :destroy) 
    end

    it 'allows teams' do 
      should allow_action(:teams, :new)  
      should allow_action(:teams, :show) 
      should allow_action(:teams, :create)  
      should allow_action(:teams, :index) 
      should allow_action(:teams, :update, users_team)  
      should allow_action(:teams, :edit, users_team) 
      should allow_action(:teams, :destroy, users_team) 
      should_not allow_action(:teams, :update)  
      should_not allow_action(:teams, :edit) 
      should_not allow_action(:teams, :destroy) 
      should_not allow_action(:teams, :update, other_team)  
      should_not allow_action(:teams, :edit, other_team) 
      should_not allow_action(:teams, :destroy, other_team) 
    end

    it 'allows texts' do 
      should allow_action(:texts, :create)  
      should allow_action(:texts, :index) 
      should allow_action(:texts, :show, users_text)  
      should allow_action(:texts, :show, other_text) 
      should allow_action(:texts, :update, users_text) 
      should allow_action(:texts, :destroy , users_text)  
      should allow_action(:texts, :edit , users_text) 
      should_not allow_action(:texts, :update) 
      should_not allow_action(:texts, :destroy)  
      should_not allow_action(:texts, :edit)  
      should_not allow_action(:texts, :show) 
      should_not allow_action(:texts, :show, other_team_text)  
      should_not allow_action(:texts, :update, other_text) 
      should_not allow_action(:texts, :destroy , other_text)  
      should_not allow_action(:texts, :edit , other_text) 
    end

    it 'should not allow translations' do 
      should_not allow_action(:translations, :create)  
      should_not allow_action(:translations, :update) 
      should_not allow_action(:translations, :destroy)  
      should_not allow_action(:translations, :show)  
      should_not allow_action(:translations, :index) 
    end
end
