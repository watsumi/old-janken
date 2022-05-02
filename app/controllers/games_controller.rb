class GamesController < ApplicationController
  before_action :set_game, only: %i[show edit update destroy]
  before_action :set_fields_for_select, only: %i[new create edit update]

  # GET /games
  def index
    @games = current_user.games.all
  end

  # GET /games/1
  def show; end

  # GET /games/new
  def new
    @game = current_user.games.new
  end

  # GET /games/1/edit
  def edit; end

  # POST /games
  def create
    @game = current_user.games.new(game_params)

    if @game.save
      redirect_to @game, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      redirect_to @game, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
    redirect_to games_url, notice: t('.success')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = current_user.games.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def game_params
    params.require(:game).permit(:id, :field_id)
  end

  def set_fields_for_select
    @fields_for_select = Field.all.pluck(:title, :id)
  end
end
