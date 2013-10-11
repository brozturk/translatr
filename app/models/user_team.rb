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


end
