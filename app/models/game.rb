# == Schema Information
#
# Table name: games
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  field_id   :integer          default(1), not null
#  guest_id   :integer
#  user_id    :uuid             not null
#
# Indexes
#
#  index_games_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Game < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  has_many :game_details, dependent: :destroy
  belongs_to :user
  belongs_to_active_hash :field, class_name: 'Field', inverse_of: :games

  validates :field_id, presence: true
end
