require "spec_helper"

describe Permission do 
  describe 'as a non user' do 
    subject { Permission.new(nil) } 
    it { should allow_action("sessions", "new") }
    it { should allow_action("sessions", "create") } 
    it { should allow_action("sessions", "destroy") } 

    it { should allow_action("users", "new") } 
    it { should allow_action("users", "create") } 
  end

  describe 'regular user' do 
    user = FactoryGirl.create(:user, translator: false, leader: false)
    subject { Permission.new(user) } 
    it { should allow_action("sessions", "new") }
    it { should allow_action("sessions", "create") } 
    it { should allow_action("sessions", "destroy") } 

    it { should allow_action("users", "new") } 
    it { should allow_action("users", "create") } 
    it { should allow_action("users", "index") } 
    it { should allow_action("users", "show") } 
    it { should allow_action("users", "update") } 
    it { should allow_action("users", "edit") } 

    it { should allow_action("user_teams", "index") } 
    it { should allow_action("user_teams", "update") } 
    it { should allow_action("user_teams", "create") } 

    it { should allow_action("teams", "new") } 
    it { should allow_action("teams", "create") } 
    it { should allow_action("teams", "index") } 
    
    it { should_not allow_action("translations", "create") } 
    it { should_not allow_action("translations", "update") } 
    it { should_not allow_action("translations", "destroy") } 
    it { should_not allow_action("translations", "show") } 
    it { should_not allow_action("translations", "index") } 
    
    it { should_not allow_action("texts", "create") } 
    it { should_not allow_action("texts", "update") } 
    it { should_not allow_action("texts", "destroy") } 
    it { should_not allow_action("texts", "show") } 
    it { should_not allow_action("texts", "index") } 
    
  end

  describe 'user with a team' do 

    before do 
      @user = FactoryGirl.create(:user)
      team = FactoryGirl.create(:team)
      relationship = FactoryGirl.create(:user_team, user_id: @user.id, team_id: team.id, state: 'accepted')
    end

    subject { Permission.new(@user) } 
    it { should allow_action("sessions", "new") }
    it { should allow_action("sessions", "create") } 
    it { should allow_action("sessions", "destroy") } 

    it { should allow_action("users", "new") } 
    it { should allow_action("users", "create") } 
    it { should allow_action("users", "index") } 
    it { should allow_action("users", "show") } 
    
    it { should allow_action("user_teams", "index") } 
    it { should allow_action("user_teams", "update") } 
    it { should allow_action("user_teams", "create") } 

    it { should allow_action("teams", "create") } 
    it { should allow_action("teams", "new") } 
    it { should allow_action("teams", "create") } 
    it { should allow_action("teams", "index") } 

    it { should allow_action("texts", "create") } 
    it { should allow_action("texts", "show") } 
    it { should allow_action("texts", "index") } 
  
    it { should_not allow_action("translations", "create") } 
    it { should_not allow_action("translations", "update") } 
    it { should_not allow_action("translations", "destroy") } 
    it { should_not allow_action("translations", "show") } 
    it { should_not allow_action("translations", "index") } 

    it { should_not allow_action("teams", "update") } 
    it { should_not allow_action("teams", "destroy") } 
  end
  
  describe 'user as a team leader' do 

    before do 
      @user = FactoryGirl.create(:user, leader: true)
      team = FactoryGirl.create(:team)
      team.leader_id = @user.id
      relationship = FactoryGirl.create(:user_team, user_id: @user.id, team_id: team.id, state: 'accepted')
    end

    subject { Permission.new(@user) } 
    it { should allow_action("sessions", "new") }
    it { should allow_action("sessions", "create") } 
    it { should allow_action("sessions", "destroy") } 

    it { should allow_action("users", "new") } 
    it { should allow_action("users", "create") } 
    it { should allow_action("users", "index") } 
    it { should allow_action("users", "show") } 

    it { should allow_action("user_teams", "index") } 
    it { should allow_action("user_teams", "create") } 
    it { should allow_action("user_teams", "update") } 

    it { should allow_action("teams", "new") } 
    it { should allow_action("teams", "update") } 
    it { should allow_action("teams", "edit") } 
    it { should allow_action("teams", "destroy") } 
    it { should allow_action("teams", "create") } 
    it { should allow_action("teams", "index") } 

    it { should allow_action("texts", "create") } 
    it { should allow_action("texts", "show") } 
    it { should allow_action("texts", "index") } 
  
    it { should_not allow_action("translations", "create") } 
    it { should_not allow_action("translations", "update") } 
    it { should_not allow_action("translations", "destroy") } 
    it { should_not allow_action("translations", "show") } 
    it { should_not allow_action("translations", "index") } 
  end

  describe 'user as a translator' do 

    before do 
      @user = FactoryGirl.create(:user, translator: true, leader: false)
      team = FactoryGirl.create(:team)
      team.leader_id = @user.id
      relationship = FactoryGirl.create(:user_team, user_id: @user.id, team_id: team.id, state: 'accepted')
    end

    subject { Permission.new(@user) } 
    it { should allow_action("sessions", "new") }
    it { should allow_action("sessions", "create") } 
    it { should allow_action("sessions", "destroy") } 

    it { should allow_action("users", "new") } 
    it { should allow_action("users", "create") } 
    it { should allow_action("users", "index") } 
    it { should allow_action("users", "show") } 
    it { should allow_action("users", "edit") } 
    it { should allow_action("users", "update") } 

    it { should allow_action("user_teams", "index") } 
    it { should allow_action("user_teams", "create") } 
    it { should allow_action("user_teams", "update") } 

    it { should allow_action("teams", "new") } 
    it { should allow_action("teams", "create") } 
    it { should allow_action("teams", "index") } 
    it { should allow_action("teams", "show") } 

    it { should allow_action("texts", "show") } 
    it { should allow_action("texts", "index") } 

    it { should allow_action("translations", "create") } 

    it { should_not allow_action("texts", "create") } 
    it { should_not allow_action("texts", "update") } 
    it { should_not allow_action("texts", "edit") } 
    it { should_not allow_action("texts", "new") } 
  
    it { should_not allow_action("teams", "edit") } 
    it { should_not allow_action("teams", "update") } 
    it { should_not allow_action("teams", "destroy") } 
  end
end
