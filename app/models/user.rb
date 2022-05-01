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
class User < ApplicationRecord
  attr_accessor :user_token

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
