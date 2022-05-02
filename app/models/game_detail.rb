# == Schema Information
#
# Table name: game_details
#
#  id            :uuid             not null, primary key
#  attacker_role :integer          not null
#  hand          :integer          not null
#  round_score   :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  game_id       :string           not null
#  request_id    :integer          not null
#  support_id    :integer          not null
#  user_id       :string           not null
#
# Indexes
#
#  index_game_details_on_user_id_and_game_id  (user_id,game_id)
#
class GameDetail < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :attacker_role, inclusion: { in: Board::ATTACKER_ROLES }

  self.implicit_order_column = "created_at"
end
