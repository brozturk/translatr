class Team < ActiveRecord::Base
  validates :name, presence: true
  
  has_many :user_teams

  has_many :users, -> { where status: 'accepted' }, through: :user_teams

  has_many :requested_user_teams, -> { where status: 'requested' }, foreign_key: :team_id, class_name: 'UserTeam'
  has_many :requested_users, through: :requested_user_teams, source: :user

  has_many :kicked_user_teams, -> { where status: 'kicked' }, foreign_key: :team_id, class_name: 'UserTeam'
  has_many :kicked_users, through: :kicked_user_teams, source: :user
  
  has_many :texts, through: :users
  has_many :translations, through: :users




  
end
