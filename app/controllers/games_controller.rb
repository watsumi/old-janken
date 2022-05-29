class GamesController < ApplicationController
  skip_before_action :require_login, only: %i[index create paticipates]
  before_action :set_game, only: %i[show destroy paticipates]

  # GET /games
  def index
    @games = Game.open.limit(15)
  end

  # GET /games/1
  def show; end

  # POST /games
  def create
    Game.transaction do
      respond_to do |format|
        @game = Game.new(field: Field.all.sample)
        host = @game.users.build(role: :host, character: Character.all.sample)
        @game.users.build(role: :guest, character: Character.all.sample)
        host.set_user_token

        if @game.create_game_and_set_user_cards!
          remember(host)
          format.html { redirect_to @game }
          format.json { render :show, status: :ok, location: @game }
          @game.notify_to_game('ゲームを作成しました！')
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
    redirect_to root_path
  end

  def paticipates; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
    @host = @game.host
    @guest = @game.guest
  end
end
