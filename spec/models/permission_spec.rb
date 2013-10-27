require "spec_helper"

describe Permission do 
  describe 'as a non user' do 
    subject { Permission.new(nil) } 
    it { should allow_action(:sessions, :new) }
    it { should allow_action(:sessions, :create) } 
    it { should allow_action(:sessions, :destroy) } 

    it { should allow_action(:users, :new) } 
    it { should allow_action(:users, :create) } 
  end

  describe 'regular user' do 
    user = FactoryGirl.create(:user, translator: false, leader: false)
    subject { Permission.new(user) } 
    it { should allow_action(:sessions, :new) }
    it { should allow_action(:sessions, :create) } 
    it { should allow_action(:sessions, :destroy) } 

    it { should allow_action(:users, :new) } 
    it { should allow_action(:users, :create) } 
    it { should allow_action(:users, :index) } 
    it { should allow_action(:users, :show) } 
    it { should allow_action(:users, :update) } 
    it { should allow_action(:users, :edit) } 

    it { should allow_action(:user_teams, :index) } 
    it { should allow_action(:user_teams, :update) } 
    it { should allow_action(:user_teams, :create) } 

    it { should allow_action(:teams, :new) } 
    it { should allow_action(:teams, :create) } 
    it { should allow_action(:teams, :index) } 
    
    it { should_not allow_action(:translations, :create) } 
    it { should_not allow_action(:translations, :update) } 
    it { should_not allow_action(:translations, :destroy) } 
    it { should_not allow_action(:translations, :show) } 
    it { should_not allow_action(:translations, :index) } 
    
    it { should_not allow_action(:texts, :create) } 
    it { should_not allow_action(:texts, :update) } 
    it { should_not allow_action(:texts, :destroy) } 
    it { should_not allow_action(:texts, :show) } 
    it { should_not allow_action(:texts, :index) } 
    
  end

  describe 'user with a team' do 

    before do 
      @user = FactoryGirl.create(:user)
      @other_user = FactoryGirl.create(:user)
      team = FactoryGirl.create(:team)
      relationship = FactoryGirl.create(:user_team, user_id: @user.id, team_id: team.id, state: 'accepted')
      relationship2 = FactoryGirl.create(:user_team, user_id: @other_user.id, team_id: team.id, state: 'accepted')
      @users_text = FactoryGirl.create(:text, user_id: @user.id, team_id: team.id)
      @other_text = FactoryGirl.create(:text, user_id: @other_user.id,  team_id: team.id)
    end

    subject { Permission.new(@user) } 
    it { should allow_action(:sessions, :new) }
    it { should allow_action(:sessions, :create) } 
    it { should allow_action(:sessions, :destroy) } 

    it { should allow_action(:users, :new) } 
    it { should allow_action(:users, :create) } 
    it { should allow_action(:users, :index) } 
    it { should allow_action(:users, :show) } 
    
    it { should allow_action(:user_teams, :index) } 
    it { should allow_action(:user_teams, :update) } 
    it { should allow_action(:user_teams, :create) } 

    it { should allow_action(:teams, :create) } 
    it { should allow_action(:teams, :new) } 
    it { should allow_action(:teams, :create) } 
    it { should allow_action(:teams, :index) } 

    it { should allow_action(:texts, :create) } 
    it { should allow_action(:texts, :show) } 
    it { should allow_action(:texts, :index) } 
    it { should allow_action(:texts, :update, @users_text) } 
    it { should allow_action(:texts, :destroy , @users_text) } 
    it { should allow_action(:texts, :edit , @users_text) } 
  
    it { should_not allow_action(:translations, :create) } 
    it { should_not allow_action(:translations, :update) } 
    it { should_not allow_action(:translations, :destroy) } 
    it { should_not allow_action(:translations, :show) } 
    it { should_not allow_action(:translations, :index) } 

    it { should_not allow_action(:teams, :update) } 
    it { should_not allow_action(:teams, :destroy) } 

    it { should_not allow_action(:texts, :update) } 
    it { should_not allow_action(:texts, :destroy) } 
    it { should_not allow_action(:texts, :edit) } 
    it { should_not allow_action(:texts, :update, @other_text) } 
    it { should_not allow_action(:texts, :destroy , @other_text) } 
    it { should_not allow_action(:texts, :edit , @other_text) } 
  end
  
  describe 'user as a team leader' do 

    before do 
      @user = FactoryGirl.create(:user, leader: true)
      @other_user = FactoryGirl.create(:user)
      @users_team = FactoryGirl.create(:team)
      @users_team.leader_id = @user.id
      @user.leader_of_team = @users_team.id
      relationship = FactoryGirl.create(:user_team, user_id: @user.id, team_id: @users_team.id, state: 'accepted')
      relationship2 = FactoryGirl.create(:user_team, user_id: @other_user.id, team_id: @users_team.id, state: 'accepted')
      @other_team = FactoryGirl.create(:team)
      @users_text = FactoryGirl.create(:text, user_id: @user.id, team_id: @users_team.id)
      @other_text = FactoryGirl.create(:text, user_id: @other_user.id,  team_id: @users_team.id)
    end

    subject { Permission.new(@user) } 
    it { should allow_action(:sessions, :new) }
    it { should allow_action(:sessions, :create) } 
    it { should allow_action(:sessions, :destroy) } 

    it { should allow_action(:users, :new) } 
    it { should allow_action(:users, :create) } 
    it { should allow_action(:users, :index) } 
    it { should allow_action(:users, :show) } 

    it { should allow_action(:user_teams, :index) } 
    it { should allow_action(:user_teams, :create) } 
    it { should allow_action(:user_teams, :update) } 

    it { should allow_action(:teams, :new) } 
    it { should allow_action(:teams, :show) } 
    it { should allow_action(:teams, :create) } 
    it { should allow_action(:teams, :index) } 
    it { should allow_action(:teams, :update, @users_team) } 
    it { should allow_action(:teams, :edit, @users_team) } 
    it { should allow_action(:teams, :destroy, @users_team) } 

    it { should allow_action(:texts, :create) } 
    it { should allow_action(:texts, :show) } 
    it { should allow_action(:texts, :index) } 
    it { should allow_action(:texts, :update, @users_text) } 
    it { should allow_action(:texts, :destroy , @users_text) } 
    it { should allow_action(:texts, :edit , @users_text) } 
  
    it { should_not allow_action(:translations, :create) } 
    it { should_not allow_action(:translations, :update) } 
    it { should_not allow_action(:translations, :destroy) } 
    it { should_not allow_action(:translations, :show) } 
    it { should_not allow_action(:translations, :index) } 

    it { should_not allow_action(:teams, :update) } 
    it { should_not allow_action(:teams, :edit) } 
    it { should_not allow_action(:teams, :destroy) } 
    it { should_not allow_action(:teams, :update, @other_team) } 
    it { should_not allow_action(:teams, :edit, @other_team) } 
    it { should_not allow_action(:teams, :destroy, @other_team) } 

    it { should_not allow_action(:texts, :update) } 
    it { should_not allow_action(:texts, :destroy) } 
    it { should_not allow_action(:texts, :edit) } 
    it { should_not allow_action(:texts, :update, @other_text) } 
    it { should_not allow_action(:texts, :destroy , @other_text) } 
    it { should_not allow_action(:texts, :edit , @other_text) } 
  end

  describe 'user as a translator' do 

    before do 
      @user = FactoryGirl.create(:user, translator: true, leader: false)
      team = FactoryGirl.create(:team)
      team.leader_id = @user.id
      relationship = FactoryGirl.create(:user_team, user_id: @user.id, team_id: team.id, state: 'accepted')
    end

    subject { Permission.new(@user) } 
    it { should allow_action(:sessions, :new) }
    it { should allow_action(:sessions, :create) } 
    it { should allow_action(:sessions, :destroy) } 

    it { should allow_action(:users, :new) } 
    it { should allow_action(:users, :create) } 
    it { should allow_action(:users, :index) } 
    it { should allow_action(:users, :show) } 
    it { should allow_action(:users, :edit) } 
    it { should allow_action(:users, :update) } 

    it { should allow_action(:user_teams, :index) } 
    it { should allow_action(:user_teams, :create) } 
    it { should allow_action(:user_teams, :update) } 

    it { should allow_action(:teams, :new) } 
    it { should allow_action(:teams, :create) } 
    it { should allow_action(:teams, :index) } 
    it { should allow_action(:teams, :show) } 

    it { should allow_action(:texts, :show) } 
    it { should allow_action(:texts, :index) } 

    it { should allow_action(:translations, :create) } 

    it { should_not allow_action(:texts, :create) } 
    it { should_not allow_action(:texts, :update) } 
    it { should_not allow_action(:texts, :edit) } 
    it { should_not allow_action(:texts, :new) } 
  
    it { should_not allow_action(:teams, :edit) } 
    it { should_not allow_action(:teams, :update) } 
    it { should_not allow_action(:teams, :destroy) } 
  end
end
