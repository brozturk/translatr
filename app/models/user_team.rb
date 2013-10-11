class UserTeam < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  state_machine :state, initial: :pending do

    state :requested
  end

  def self.request(team, user)
    transaction do 
      create(user_id: user.id, team_id: team.id, state: 'requested') 
    end
  end

end
