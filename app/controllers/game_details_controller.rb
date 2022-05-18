class GameDetailsController < ApplicationController
  before_action :set_game, only: %i[index]
  before_action :set_last_game_detail, only: %i[index]

  def index
    if @last_game_detail.guest_turn_1? || @last_game_detail.host_turn_1?
      limit = 0
    elsif @last_game_detail.guest_turn_2? || @last_game_detail.host_turn_2?
      limit = 2
    elsif @last_game_detail.guest_turn_3? || @last_game_detail.host_turn_3?
      limit = 4
    else
      @last_game_detail.finished?
      limit = 6
    end
    @game_details = GameDetail.where(game_id: @game.id).order(:created_at).limit(limit)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_last_game_detail
    @last_game_detail = GameDetail.where(game_id: @game.id).order(:created_at).last
  end
end
