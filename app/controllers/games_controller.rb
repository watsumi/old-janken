class GamesController < ApplicationController
  before_action :set_game, only: %i[show host guest spectator]

  # GET /games
  def index
    @games = Game.all
  end

  # GET /games/1
  def show
    if @game.host.authenticated?(session)
      redirect_to action: :host, id: @game.id
      return
    end

    if @game.guest.authenticated?(session)
      redirect_to action: :guest, id: @game.id
      return
    end

    @guest = @game.guest
  end

  # POST /games
  def create
    game = Game.new(
      field_id: Field.all.sample.id,
    )
    host = game.users.build(
      role: :host,
      character_id: Character.all.sample.id,
      support_id: Support.all.sample.id,
    )
    guest = game.users.build(
      role: :guest,
      character_id: Character.all.sample.id,
      support_id: Support.all.sample.id,
    )

    host.set_user_token
    game.save!
    3.times do
      host.set_hand!(host.character.name)
      guest.set_hand!(guest.character.name)
    end
    remember(host)

    redirect_to action: :host, id: game.id
  end

  def host
    @account = @game.host
    @enemy = @game.guest

    redirect_to action: :show unless @account.authenticated?(session)
  end

  def guest
    @account = @game.guest

    redirect_to action: :show unless @account.authenticated?(session)
  end

  def spectator
    @account = @game.spectator
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end
end
