module UsersHelper
  def enemy?(user)
    if current_user&.host_role?
      user.guest_role?
    elsif current_user&.guest_role?
      user.host_role?
    end
  end
end
