class Team < ActiveRecord::Base
  has_many :users, through: :user_teams
  has_many :user_teams
  has_many :texts, through: :users
  has_many :translations, through: :users

  validates :name, presence: true
end
