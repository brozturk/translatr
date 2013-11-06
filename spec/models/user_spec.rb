require 'spec_helper'

describe User do
  before { @user = create(:user) }
  subject { @user } 

  it {should validate_presence_of(:name)} 
  it {should validate_presence_of(:last_name)}
  it {should validate_presence_of(:email)}

  it {should have_many(:translations)}
  it {should have_many(:texts)}
  it {should have_many(:user_teams)} 

  it {should respond_to(:translator)}
  it {should respond_to(:password_digest)} 

  describe 'remember token' do 
    its(:remember_token) { should_not be_blank }  
  end

  describe '#send_password_reset_info' do
    let(:user) { create(:user) } 

    it 'generates a token' do 
      user.send_password_reset_info
      sent_token = user.password_reset_token
      user.send_password_reset_info
      expect(user.password_reset_token).not_to eq sent_token
    end

    it 'sets the time the token was sent' do
      user.send_password_reset_info
      expect(user.reload.password_reset_sent_at).to be_present
    end

    it 'delivers email to the user' do
      user.send_password_reset_info
      expect(open_last_email).to be_delivered_to user.email
    end
  end
end
