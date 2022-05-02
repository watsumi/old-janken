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
class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :game
  belongs_to_active_hash :character, class_name: 'Character', inverse_of: :users

  validates :character_id, presence: true
  validates :role, inclusion: { in: roles.keys }

  enum role: {
    host: 1,
    guest: 2,
    spectator: 3,
  }, _prefix: true

  attr_accessor :user_token

  self.implicit_order_column = "created_at"

  def authenticated?(user_token)
    BCrypt::Password.new(user_token_digest).is_password?(user_token)
  end

  class << self
    def create_anonymously!
      user_token = generate_user_token
      user_token_digest = generate_user_token_digest(user_token)
      create!(user_token:, user_token_digest:)
    end

    private

    def generate_user_token
      SecureRandom.urlsafe_base64
    end

    def generate_user_token_digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost:)
    end
  end
end
