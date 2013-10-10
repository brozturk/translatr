class UserTeam < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  state_machine :state, initial: :pending do

    state :requested
  end
end
