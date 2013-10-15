module UserTeamsHelper
  def group_invite_request
    UserTeam.where(user_id: current_user.id, state: 'requested')
  end

  def request_size
    group_invite_request.size
  end

  def user_has_requests?
    if group_invite_request.size == 0 
      return false
    else
      return true
    end
  end

end
