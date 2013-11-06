require 'spec_helper'

describe Permissions::LeaderAndTranslator do 
    let!(:user) { create(:user, leader: true, translator: true) } 
    let!(:other_user) { create(:user) } 
    let!(:users_team) { create(:team, leader_id: user.id) } 
    let!(:relationship) { create(:user_team, user_id: user.id, team_id: users_team.id, state: 'accepted') } 
    let!(:relationship2) { create(:user_team, user_id: other_user.id, team_id: users_team.id, state: 'accepted') } 
    let!(:other_team) { create(:team) } 
    let!(:other_relationship) { create(:user_team, user_id: other_user.id, team_id: other_team.id, state: 'accepted') } 
    let!(:users_text) { create(:text, user_id: user.id, team_id: users_team.id) } 
    let!(:team_text) { create(:text, user_id: other_user.id,  team_id: users_team.id) }
    let!(:other_text) { create(:text, user_id: other_user.id,  team_id: other_team.id) } 
    let!(:other_team_text) { create(:text, user_id: other_user.id,  team_id: users_team.id) } 
    let!(:translation) { create(:translation, user_id: user.id,  team_id: users_team.id, text_id: team_text.id) } 
    let!(:other_translation) { build(:translation, user_id: other_user.id,  team_id: users_team.id, text_id: other_team_text.id) } 

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
      should allow_action(:texts, :show, team_text) 
      should allow_action(:texts, :index) 
      should_not allow_action(:texts, :create)  
      should_not allow_action(:texts, :update)  
      should_not allow_action(:texts, :edit)  
      should_not allow_action(:texts, :new)  
      should_not allow_action(:texts, :show) 
      should_not allow_action(:texts, :show, other_text) 
    end

    it 'allows translations' do 
      should allow_action(:translations, :create) 
      should allow_action(:translations, :index) 
      should allow_action(:translations, :destroy, translation) 
      should allow_action(:translations, :update, translation) 
      should allow_action(:translations, :edit, translation) 
      should_not allow_action(:translations, :destroy)  
      should_not allow_action(:translations, :update)  
      should_not allow_action(:translations, :edit) 
      should_not allow_action(:translations, :destroy, other_translation)  
      should_not allow_action(:translations, :update, other_translation) 
      should_not allow_action(:translations, :edit, other_translation)
    end
end
