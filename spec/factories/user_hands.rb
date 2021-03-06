# == Schema Information
#
# Table name: user_hands
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  hand_id    :bigint
#  user_id    :uuid
#
# Indexes
#
#  index_user_hands_on_hand_id  (hand_id)
#  index_user_hands_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :user_hand do
    hand_id { 1 }
  end
end
