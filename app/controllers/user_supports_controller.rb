class UserSupportsController < ApplicationController
  before_action :set_game_variables

  def show; end

  def edit
    @card = @user_support.support
  end

  def destroy
    apply_support! unless @user_support.support.id != 3 && @user.guest_role? && @user.user_hands.size == 1
    @user_support.destroy
    notice = "#{@user_support.user.role}が#{@user_support.support.name}を使用しました"
    respond_to do |format|
      format.turbo_stream {}
      format.html { redirect_to @user_support, notice: notice }
    end

    @game.notify_to_game(notice)
  end

  private
    def set_game_variables
      @user_support = UserSupport.find(params[:id])
      @game = Game.find(params[:game_id])
      @user = @user_support.user
    end

    def apply_support!
      @game.game_details.last.update!(support_id: @user_support.support.id)
      @user.update_by_support_card!(@user_support.support.id)
    end
end
