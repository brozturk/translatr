module Permissions
  class TranslatorPermission < BasePermission
    def initialize(user)
      allow :sessions, [:new, :create, :destroy] 
      allow :users, [:show, :edit, :update, :new, :create] 
      allow :teams, [:new, :create, :index] 
      allow :user_teams, [:create, :update, :index]
      allow :texts, [:index]
      allow :texts, [:show] do |text|
        text.team.in?(user.teams)
      end
      allow :translations, [:create, :index] 
      allow :translations, [:destroy, :update, :edit] do |translation|
        translation.in?(user.translations)
      end
    end
  end
end
