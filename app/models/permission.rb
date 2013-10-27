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
      allow :teams, [:new, :create, :index, :show] 
      allow :user_teams, [:create, :update, :index]
      allow :texts, [:show, :create, :new, :index]
    elsif  user && user.teams.count > 0 && !user.translator && user.leader 
      allow :users, [:index, :show, :edit, :update]
      allow :teams, [:new, :create, :index, :show, :update, :edit, :destroy] 
      allow :user_teams, [:create, :update, :index]
      allow :texts, [:show, :create, :new, :index]
    elsif user && user.translator 
      allow :users, [:index, :show, :edit, :update]
      allow :teams, [:new, :create, :index, :show] 
      allow :user_teams, [:create, :update, :index]
      allow :texts, [:show, :index]
      allow :translations, [:create] 
    end
  end

  def allow?(controller, action)
    @allowed_actions[[controller.to_s, action.to_s]] 
  end

  def allow(controllers, actions)
    @allowed_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = true
      end
    end
  end
end
