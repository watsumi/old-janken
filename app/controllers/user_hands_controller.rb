class UserHandsController < ApplicationController
  before_action :set_user_hand, only: %i[show edit destroy]
  before_action :set_game, only: %i[show edit destroy]

  def show
    if request.headers['turbo-frame']
      render partial: 'user_hand', locals: { user_hand: @user_hand }
    else
      render 'show'
    end
  end

  def edit
    @card = @user_hand.hand
  end

  def destroy
    @user_hand.destroy
    if params[:cpu_game]
      cpu_turn_change!
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to cpu_game_path(@game), notice: notice_next_turn }
      end
    else
      turn_change!
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to game_path(@game), notice: notice_next_turn }
      end
    end

    @game.notify_to_game(notice)
  end

  private

  def set_user_hand
    @user_hand = UserHand.find(params[:id])
  end

  def set_game
    @game = @user_hand.user.game
  end

  def turn_change!
    @game.game_details.last.update!(hand_id: @user_hand.hand.id)
    @game.turn_end!
  end

  def cpu_turn_change!
    @game.game_details.last.update!(hand_id: @user_hand.hand.id)
    @game.turn_end!
    @game.cpu_turn_activate!
  end

  def notice_next_turn
    if @game.game_details.last.finished?
      "ゲーム終了！#{@game.winner_role}"
    else
      "#{@game.game_details.last.user.role}のターンです"
    end
  end
end
