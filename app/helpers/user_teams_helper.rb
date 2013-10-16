module UserTeamsHelper
  def group_invite_request
    UserTeam.where(user_id: current_user.id, state: 'requested')
  end

  def request_size
    group_invite_request.size
  end

  def user_has_requests?
    if group_invite_request.size == 0 
      false
    else
      true
    end
  end

  def accepted_user_teams
    UserTeam.where(user_id: current_user.id, state: 'accepted')
  end

  def user_has_accepted_team?
    if accepted_user_teams.size == 0 
      false
    else
      true
    end
  end

end
