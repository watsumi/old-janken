# == Schema Information
#
# Table name: users
#
#  id                :uuid             not null, primary key
#  role              :integer          not null
#  user_token_digest :string           default(""), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  character_id      :integer          default(1), not null
#  game_id           :string           not null
#
# Indexes
#
#  index_users_on_game_id_and_role  (game_id,role) UNIQUE
#
FactoryBot.define do
  factory :user do
    sequence(:nickname) { |n| "Nick Name #{n.to_s.rjust(5, '0')}" }
    character_id { 1 }
  end
end
