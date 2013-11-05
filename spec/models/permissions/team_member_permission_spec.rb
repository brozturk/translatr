require 'spec_helper'

describe Permissions::TeamMemberPermission do
    let!(:user) { create(:user) } 
    let!(:other_user) { create(:user) }
    let!(:other_team) { create(:team) } 
    let!(:team) { create(:team) }
    let!(:relationship) { create(:user_team, user_id: user.id, team_id: team.id, state: 'accepted') }
    let!(:relationship2) { create(:user_team, user_id: other_user.id, team_id: team.id, state: 'accepted') } 
    let!(:users_text) { build(:text, user_id: user.id, team_id: team.id) } 
    let!(:other_text) { build(:text, user_id: other_user.id,  team_id: team.id) } 
    let!(:other_team_text) { build(:text, user_id: other_user.id,  team_id: other_team.id) } 
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
      should allow_action(:user_teams, :update)  
      should allow_action(:user_teams, :create) 
      should allow_action(:user_teams, :edit, relationship)  
      should allow_action(:user_teams, :destroy, relationship) 
      should_not allow_action(:user_teams, :edit)  
      should_not allow_action(:user_teams, :destroy) 
    end

    it 'allows teams' do 
      should allow_action(:teams, :new)  
      should allow_action(:teams, :create)  
      should allow_action(:teams, :index)  
      should allow_action(:teams, :show, team)
      should_not allow_action(:teams, :update)  
      should_not allow_action(:teams, :destroy)  
      should_not allow_action(:teams, :show)  
      should_not allow_action(:teams, :show, other_team) 
    end

    it 'allows texts' do 
      should allow_action(:texts, :create)  
      should allow_action(:texts, :index)  
      should allow_action(:texts, :new)  
      should allow_action(:texts, :show, users_text)  
      should allow_action(:texts, :personal)  
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

    it 'does not allow translations' do
      should_not allow_action(:translations, :create)  
      should_not allow_action(:translations, :update)  
      should_not allow_action(:translations, :destroy)  
      should_not allow_action(:translations, :show)  
      should_not allow_action(:translations, :index)  
    end

end
