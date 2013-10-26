class Permission < Struct.new(:user)
  def allow?(controller, action)
    return true if controller == 'sessions'
    return true if controller == 'users' && action.in?(%w[new create])

    if user && user.teams.count == 0 && !user.translator
      return true if controller == 'users' && action.in?(%w[index show edit update])
      return true if controller == 'teams' && action.in?(%w[new create index])
      return true if controller == 'user_teams' && action.in?(%w[create index update])

    elsif !user.leader && !user.translator && user.teams.count > 0
      return true if controller == 'users' && action.in?(%w[index show edit update])
      return true if controller == 'teams' && action.in?(%w[show new create index])
      return true if controller == 'user_teams' && action.in?(%w[create index update])
      return true if controller == 'texts' && action.in?(%w[show new create index])

    elsif  user.teams.count > 0 && !user.translator && user.leader 
      return true if controller == 'users' && action.in?(%w[index show edit update])
      return true if controller == 'teams' && action.in?(%w[show new create index update edit destroy])
      return true if controller == 'user_teams' && action.in?(%w[create index update])
      return true if controller == 'texts' && action.in?(%w[show new create index])

    elsif user.translator 
      return true if controller == 'users' && action.in?(%w[index show edit update])
      return true if controller == 'teams' && action.in?(%w[show new create index])
      return true if controller == 'user_teams' && action.in?(%w[create index update])
      return true if controller == 'texts' && action.in?(%w[show index])
      return true if controller == 'translations' && action.in?(%w[create])
    end
  end
end
