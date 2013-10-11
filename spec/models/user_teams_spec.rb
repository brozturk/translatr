require 'spec_helper'

describe UserTeam do 
  before do
    @user = create(:user)
    @team = create(:team)
    @user_team = create(:user_team, user_id: @user.id, team_id: @team.id)
  end
  subject { @user_team }

  it { should belong_to(:user) }
  it { should belong_to(:team) } 

  describe 'assigning a user to a team with user_id should have pending state' do
    its(:state) { should eq 'requested' }
  end

  describe 'requested UserTeam' do 
    before do
      (@user_team.accept)
    end
    it 'should have a state of requested' do 
      (@user_team.state).should eq 'accepted'
    end
  end

end

