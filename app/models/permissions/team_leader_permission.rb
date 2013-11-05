module Permissions
  class TeamLeaderPermission < BasePermission
    def initialize(user)
      allow :sessions, [:new, :create, :destroy] 
      allow :users, [:new, :create] 
      allow :users, [:index, :show, :edit, :update]
      allow :teams, [:new, :create, :index, :show] 
      allow :teams, [:update, :edit, :destroy] do |team|
        team.leader_id == user.id
      end
      allow :user_teams, [:create, :index, :update]
      allow :user_teams, [:destroy] do |relationship|
        relationship.team.leader_id == user.id
      end
      allow :texts, [ :create, :new, :index, :personal]
      allow :texts, [:update, :edit, :destroy] do |text|
        text.user_id == user.id
      end
      allow :texts, [:show] do |text|
        text.team.in?(user.teams)
      end
      allow :translations, [:index]
    end
  end
end
