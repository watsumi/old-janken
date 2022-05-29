class GameDetailsController < ApplicationController
  before_action :set_game, only: %i[index]
  before_action :set_last_game_detail, only: %i[index]

  def index
    @game_details = GameDetail.where(game_id: @game.id).order(:created_at).limit(limit_size)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_last_game_detail
    @last_game_detail = GameDetail.where(game_id: @game.id).order(:created_at).last
  end

  def limit_size
    if @last_game_detail.guest_turn1? || @last_game_detail.host_turn1?
      0
    elsif @last_game_detail.guest_turn2? || @last_game_detail.host_turn2?
      2
    elsif @last_game_detail.guest_turn3? || @last_game_detail.host_turn3?
      4
    elsif @last_game_detail.finished?
      6
    end
  end
end
