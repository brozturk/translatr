class Team < ActiveRecord::Base
  validates :name, presence: true
  
  has_many :user_teams

  has_many :users, -> { where user_teams: { state: 'accepted' } }, through: :user_teams

  has_many :requested_user_teams, -> { where user_teams: { state: 'requested' } }, foreign_key: :team_id, class_name: 'UserTeam'
  has_many :requested_users, through: :requested_user_teams, source: :user

  has_many :kicked_user_teams, -> { where user_teams: { state: 'kicked' } }, foreign_key: :team_id, class_name: 'UserTeam'
  has_many :kicked_users, through: :kicked_user_teams, source: :user
  
  has_many :texts, through: :users
  has_many :translations, through: :users
  
end
