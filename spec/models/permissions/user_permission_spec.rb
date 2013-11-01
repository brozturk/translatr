require 'spec_helper'

describe Permissions::UserPermission do 
  let(:user) { create(:user, translator: false, leader: false) } 
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
    should allow_action(:users, :update)
    should allow_action(:users, :edit) 
  end

  it 'allows user_teams' do 
    should allow_action(:user_teams, :index) 
    should allow_action(:user_teams, :update)
    should allow_action(:user_teams, :create)
  end

  it 'allows teams' do 
    should allow_action(:teams, :new) 
    should allow_action(:teams, :create) 
    should allow_action(:teams, :index)
  end

  it 'does not allow translations' do 
    should_not allow_action(:translations, :create) 
    should_not allow_action(:translations, :update)  
    should_not allow_action(:translations, :destroy)  
    should_not allow_action(:translations, :show) 
    should_not allow_action(:translations, :index)
  end

  it 'does not allow texts' do 
    should_not allow_action(:texts, :create)  
    should_not allow_action(:texts, :update)  
    should_not allow_action(:texts, :destroy)  
    should_not allow_action(:texts, :show)  
    should_not allow_action(:texts, :index) 
  end
end
