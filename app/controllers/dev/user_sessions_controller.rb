class Dev::UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[login_as]

  def login_as
    game = Game.find(params[:game_id])
    User.transaction do
      user = User.lock.find_by!(game_id: params[:game_id], id: params[:user_id])
      user.set_user_token
      user.save!
      remember(user)
    end

    redirect_to game_path(id: params[:game_id])
  end
end
