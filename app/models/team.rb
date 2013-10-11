class Team < ActiveRecord::Base
  validates :name, presence: true
  
  has_many :users, through: :user_teams,
                  conditions: { user_teams: { state: 'accepted' } } 
  has_many :user_teams
  has_many :texts, through: :users
  has_many :translations, through: :users




  
end
