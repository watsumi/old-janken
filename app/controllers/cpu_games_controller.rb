class CpuGamesController < ApplicationController
  skip_before_action :require_login, only: %i[create]
  before_action :set_game, only: %i[show destroy]

  def show; end

  def create
    Game.transaction do
      respond_to do |format|
        @game = Game.new(field: Field.all.sample)
        host = @game.users.build(role: :host, character: Character.all.sample)
        @game.users.build(role: :guest, character: Character.all.sample, user_token_digest: 'cpu_token')
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
    redirect_to games_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
    @host = @game.host
    @guest = @game.guest
  end
end
