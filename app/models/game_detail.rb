class GameDetail < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :game
  belongs_to_active_hash :hand, class_name: 'Hand', inverse_of: :game_details
  belongs_to_active_hash :support, class_name: 'Support', inverse_of: :game_details

  enum turn: {
    host_turn_1:  1,
    guest_turn_1: 2,
    host_turn_2:  3,
    guest_turn_2: 4,
    host_turn_3:  5,
    guest_turn_3: 6,
    finished: 7,
  }

  def host_turn?
    turn.match(/host_turn_\d/)
  end

  def guest_turn?
    turn.match(/guest_turn_\d/)
  end

  def round_num
    "Round #{turn.gsub(/(ho|gue)st_turn_/, '')}"
  end

  # def user_hand = @user_hand ||= Hand.find_by!(id: hand_id) if hand_id.present?

  # def user_support = @user_support ||= Support.find_by!(id: support_id) if support_id.present?
end
