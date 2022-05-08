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
