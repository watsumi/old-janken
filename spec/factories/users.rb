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
#  game_id           :string           not null
#  support_id        :string           not null
#
# Indexes
#
#  index_users_on_game_id_and_role  (game_id,role) UNIQUE
#
FactoryBot.define do
  factory :user do
    sequence(:character_id) { rand(1..3) }
    sequence(:support_id) { rand(1..3) }
  end
end
