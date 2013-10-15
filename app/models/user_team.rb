class UserTeam < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  state_machine :state, initial: :requested do

    state :accepted
    state :kicked 
    state :denied
    
    event :accept do
      transition any => :accepted
    end

    event :kick do
      transition any => :kicked
    end
    
    event :deny do
      transition any => :denied
    end
  end

end
