require 'spec_helper'

describe User do
  before { @user = create (:user) }

  subject { @user } 
  it { should validate_presence_of(:name) } 
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) } 

  describe 'remember token' do 
    its(:remember_token) { should_not be_blank }  
  end
end
