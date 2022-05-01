# == Schema Information
#
# Table name: users
#
#  id                :uuid             not null, primary key
#  nickname          :string           default(""), not null
#  user_token_digest :string           default(""), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  character_id      :integer          default(1), not null
#
FactoryBot.define do
  factory :user do
    sequence(:nickname) { |n| "Nick Name #{n.to_s.rjust(5, '0')}" }
    character_id { 1 }
  end
end
