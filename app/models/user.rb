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
class User < ApplicationRecord
  class AlreadyTakenError < StandardError; end
  class NotTakenError < StandardError; end

  extend ActiveHash::Associations::ActiveRecordExtensions

  has_many :user_hands
  belongs_to :game
  belongs_to_active_hash :character, class_name: 'Character', inverse_of: :users

  validates :character_id, presence: true

  enum role: {
    host: 1,
    guest: 2,
    spectator: 3,
  }, _prefix: true

  attr_accessor :user_token

  self.implicit_order_column = 'created_at'

  def authenticated?(session)
    taken? && BCrypt::Password.new(user_token_digest).is_password?(session[:user_token])
  end

  def set_user_token
    user_token = generate_user_token
    user_token_digest = generate_user_token_digest(user_token)
    assign_attributes(user_token:, user_token_digest:)
  end

  def set_hand!(character)
    case character
    when 'ヒポグリフ'
      user_hands.create!(hand_id: [1, 2].sample)
    when 'ユバの民'
      user_hands.create!(hand_id: [2, 3].sample)
    when 'カーバンクル'
      user_hands.create!(hand_id: [1, 3].sample)
    end
  end

  def taken? = user_token_digest.present?

  private

  def generate_user_token
    SecureRandom.urlsafe_base64
  end

  def generate_user_token_digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost:)
  end
end
