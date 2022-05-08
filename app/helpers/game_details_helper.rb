module GameDetailsHelper
  def is_my_turn?(game_detail)
    if current_user&.host_role?
      game_detail.host_turn?
    elsif current_user&.guest_role?
      game_detail.guest_turn?
    else
      false
    end
  end
end
