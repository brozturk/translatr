module Permissions
  class UserPermission < BasePermission
    def initialize(user)
      allow :sessions, [:new, :create, :destroy] 
      allow :users, [:new, :create] 
      allow :users, [:index, :show, :edit, :update]
      allow :teams, [:new, :create, :index] 
      allow :user_teams, [:create, :update, :index]
    end
  end
end

