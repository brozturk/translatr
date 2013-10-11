class Team < ActiveRecord::Base
  validates :name, presence: true
  
  has_many :users, -> { where status: 'accepted' }, through: :user_teams
  has_many :user_teams
  has_many :texts, through: :users
  has_many :translations, through: :users




  
end
