class Permission < Struct.new(:user)
  def allow?(controller, action)
    return true if controller == 'sessions'
    return true if controller == 'users' && action.in?(%w[new create])
    if user
    return true if controller == 'users' && action.in?(%w[index show edit update])
    return true if controller == 'teams' && action.in?(%w[create index])
    end
  end
end
