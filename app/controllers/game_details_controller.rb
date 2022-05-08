class GameDetailsController < ApplicationController
  before_action :set_game, only: %i[ index show ]

  def index
    @game_details = GameDetail.where(game_id: @game.id).order(:created_at).limit(6)
  end

  def show
    @game_details = GameDetail.where(game_id: @game.id).order(:created_at).limit(6)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:game_id])
    end
end
