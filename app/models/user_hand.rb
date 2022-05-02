# == Schema Information
#
# Table name: user_hands
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  hand_id    :string           not null
#  user_id    :string           not null
#
class UserHand < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to_active_hash :hand

  self.implicit_order_column = 'created_at'
end
