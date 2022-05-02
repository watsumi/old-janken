# == Schema Information
#
# Table name: games
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  field_id   :integer          default(1), not null
#
class Game < ApplicationRecord
  include Turbo::Broadcastable
  extend ActiveHash::Associations::ActiveRecordExtensions

  has_many :users, dependent: :destroy
  has_many :game_details, dependent: :destroy
  belongs_to_active_hash :field, class_name: 'Field', inverse_of: :games

  validates :field_id, presence: true

  self.implicit_order_column = 'created_at'

  def host
    @host ||= users.find_by!(role: :host)
  end

  def guest
    @guest ||= users.find_by!(role: :guest)
  end

  def spectator
    User.new(id: 'spectator', role: :spectator, game_id: id)
  end

  def user_ids
    (users + [spectator]).map(&:id)
  end
end
