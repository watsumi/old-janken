class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[authorize]
  before_action :set_user, only: %i[edit]
  before_action :set_game, only: %i[edit]

  # GET /users/1/edit
  def edit
    @card = @user.character
  end

  def authorize
    game = Game.find(params[:game_id])
    User.transaction do
      user = User.lock.find_by!(game_id: params[:game_id], id: params[:user_id])
      next if user.taken? && current_user == game.host # guestが未確定であり、current_userがホストでなければ、current_userをguestとする

      user.set_user_token
      user.save!
      remember(user)
    end

    redirect_to game_path(id: params[:game_id])
    game.notify_to_game('guestが参加しました！')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def set_game
    @game = @user.game
    @host = @game.host
    @guest = @game.guest
  end
end
