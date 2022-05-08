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
class UserHand < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to_active_hash :hand

  after_update_commit do
    broadcast_replace_to self, target: self, partial: 'user_hands/user_hand_frame', locals: { user_hand: self }
  end

  after_destroy_commit do
    broadcast_remove_to self
  end
end
