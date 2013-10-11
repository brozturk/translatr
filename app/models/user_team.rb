class UserTeam < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  state_machine :state, initial: :requested do

    state :accepted
    state :kicked 
    
    event :accept do
      transition any => :accepted
    end

    event :kick do
      transition any => :kicked
    end
  end

  def self.request(team, user)
    transaction do 
      create(user_id: user.id, team_id: team.id ) 
    end
  end

end
