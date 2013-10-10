require 'spec_helper'

describe User do
  before { @user = create (:user) }

  subject { @user } 
  it {should validate_presence_of(:name)} 
  it {should validate_presence_of(:last_name)}
  it {should validate_presence_of(:email)}

  it {should have_many(:translations)}
  it {should have_many(:texts)}
  it {should have_many(:teams).through(:user_teams)} 

  it {should respond_to(:translator)}
  it {should respond_to(:password_digest)} 

  describe 'remember token' do 
    its(:remember_token) { should_not be_blank }  
  end
end
