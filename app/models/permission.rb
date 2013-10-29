class Permission

  def initialize(user)
    allow :sessions, [:new, :create, :destroy] 
    allow :users, [:new, :create] 
    if user && user.teams.count == 0 && !user.translator
      allow :users, [:index, :show, :edit, :update]
      allow :teams, [:new, :create, :index] 
      allow :user_teams, [:create, :update, :index]
    elsif user && !user.leader && !user.translator && user.teams.count > 0
      allow :users, [:index, :show, :edit, :update]
      allow :teams, [:new, :create, :index] 
      allow :teams, [:show] do |team|
        team.in?(user.teams)
      end
      allow :user_teams, [:create, :update, :index]
      allow :texts, [ :create, :new, :index]
      allow :texts, [:update, :edit, :destroy] do |text|
        text.user_id == user.id
      end
      allow :texts, [:show] do |text|
        text.team.in?(user.teams)
      end
    elsif  user && user.teams.count > 0 && !user.translator && user.leader 
      allow :users, [:index, :show, :edit, :update]
      allow :teams, [:new, :create, :index, :show] 
      allow :teams, [:update, :edit, :destroy] do |team|
        team.leader_id == user.id
      end
      allow :user_teams, [:create, :update, :index]
      allow :texts, [ :create, :new, :index]
      allow :texts, [:update, :edit, :destroy] do |text|
        text.user_id == user.id
      end
      allow :texts, [:show] do |text|
        text.team.in?(user.teams)
      end
    elsif user && user.translator 
      allow :users, [:index, :show, :edit, :update]
      allow :teams, [:new, :create, :index, :show] 
      allow :user_teams, [:create, :update, :index]
      allow :texts, [:index]
      allow :texts, [:show] do |text|
        text.team.in?(user.teams)
      end
      allow :translations, [:create] 
    end
  end

  def allow?(controller, action, resource = nil)
    allowed = @allowed_actions[[controller.to_s, action.to_s]] 
    allowed && (allowed == true || resource && allowed.call(resource) )
  end

  def allow(controllers, actions, &block)
    @allowed_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = block || true
      end
    end
  end
end
