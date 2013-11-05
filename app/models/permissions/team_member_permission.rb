module Permissions
  class TeamMemberPermission < BasePermission
    def initialize(user)
      allow :sessions, [:new, :create, :destroy] 
      allow :users, [:new, :create, :index, :show, :edit, :update]
      allow :teams, [:new, :create, :index] 
      
      allow :teams, [:show] do |team|
        team.in?(user.teams)
      end

      allow :user_teams, [:create, :update, :index]
      allow :user_teams, [:edit, :destroy] do |relationship|
        relationship.team.in?(user.teams)
      end
      allow :texts, [:create, :new, :index, :personal]

      allow :texts, [:update, :edit, :destroy] do |text|
        text.user_id == user.id
      end

      allow :texts, [:show] do |text|
        text.team.in?(user.teams)
      end

    end
  end
end
