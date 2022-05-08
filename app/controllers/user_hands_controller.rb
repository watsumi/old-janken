class UserHandsController < ApplicationController
  before_action :set_user_hand, only: %i[ show edit destroy ]
  before_action :set_game, only: %i[ show edit destroy ]

  def show
    if request.headers["turbo-frame"]
      render partial: 'user_hand', locals: { user_hand: @user_hand }
    else
      render 'show'
    end
  end

  def edit
    @card = @user_hand.hand
  end

  def destroy
    turn_change!
    @user_hand.destroy
    notice = if @game.game_details.last.finished?
               "ゲーム終了！#{@game.winner_role}"
             else
               "#{@game.game_details.last.user.role}のターンです"
             end

    respond_to do |format|
      format.turbo_stream {}
      format.html { redirect_to @user_hand, notice: notice }
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
end
