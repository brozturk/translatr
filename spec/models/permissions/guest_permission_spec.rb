require 'spec_helper'

describe Permissions::GuestPermission do 
  subject { Permissions.permission_for(nil) } 

  it 'allows sessions' do 
    should allow_action(:sessions, :new)
    should allow_action(:sessions, :create)
    should allow_action(:sessions, :destroy)
  end

  it 'allows users' do 
    should allow_action(:users, :new)  
    should allow_action(:users, :create) 
  end
end
