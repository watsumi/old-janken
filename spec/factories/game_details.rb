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
FactoryBot.define do
  factory :game_detail do
    turn { 1 }
    hand_id { 1 }
    support_id { 1 }
  end
end
