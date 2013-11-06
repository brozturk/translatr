module Permissions
  class GuestPermission < BasePermission
    def initialize
      allow :sessions, [:new, :create, :destroy] 
      allow :users, [:new, :create] 
      allow :password_resets, [:new, :create]
    end
  end
end
