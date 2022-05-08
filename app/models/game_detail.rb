# == Schema Information
#
# Table name: game_details
#
#  id          :bigint           not null, primary key
#  round_score :integer
#  turn        :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  game_id     :uuid
#  hand_id     :integer
#  support_id  :integer
#  user_id     :uuid
#
# Indexes
#
#  index_game_details_on_game_id  (game_id)
#  index_game_details_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#  fk_rails_...  (user_id => users.id)
#
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

end
