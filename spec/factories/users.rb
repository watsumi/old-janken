# == Schema Information
#
# Table name: users
#
#  id                :uuid             not null, primary key
#  role              :integer          not null
#  user_token_digest :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  character_id      :integer          not null
#  game_id           :uuid
#
# Indexes
#
#  index_users_on_game_id  (game_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#
FactoryBot.define do
  factory :user do
    sequence(:character_id) { 1 }
  end
end
