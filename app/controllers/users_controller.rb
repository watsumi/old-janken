class UsersController < ApplicationController
  def authorize
    User.transaction do
      user = User.lock.find_by!(game_id: params[:game_id], id: params[:id])
      break if user.taken?

      user.set_user_token
      user.save!
      remember(user)
    end

    redirect_to guest_game_path(id: params[:game_id])
  end
end
