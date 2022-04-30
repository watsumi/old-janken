# == Schema Information
#
# Table name: game_details
#
#  id            :uuid             not null, primary key
#  hand_1        :integer          default(0), not null
#  hand_2        :integer          default(0), not null
#  hand_3        :integer          default(0), not null
#  round_score_1 :integer          default(0), not null
#  round_score_2 :integer          default(0), not null
#  round_score_3 :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  game_id       :uuid             not null
#  support_id    :integer          default(0), not null
#
# Indexes
#
#  index_game_details_on_game_id  (game_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#
FactoryBot.define do
  factory :game_detail do
    host { 1 }
    guest { 1 }
    game_uuid { 'MyString' }
    hand_1 { 1 }
    hand_2 { 1 }
    hand_3 { 1 }
    support_id { 1 }
    round_score_1 { 1 }
    round_score_2 { 1 }
    round_score_3 { 1 }
  end
end
