require 'spec_helper'

describe User do
it { should validate_presence_of(:name) } 
it { should validate_presence_of(:last_name) }
it { should validate_presence_of(:email) } 

@user = FactoryGirl.create(:user) 
its(:remember_token) { should_not be_blank} 

end
