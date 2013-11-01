module Permissions
  def self.permission_for(user)
    if user.nil?
      GuestPermission.new
    elsif user && user.teams.count == 0 && !user.translator
      UserPermission.new(user)
    elsif user && !user.leader && !user.translator && user.teams.count > 0
      TeamMemberPermission.new(user)
    elsif  user && user.teams.count > 0 && !user.translator && user.leader 
      TeamLeaderPermission.new(user)
    elsif user && user.translator 
      TranslatorPermission.new(user)
    end 
  end
end
