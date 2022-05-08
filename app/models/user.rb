class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  has_many :user_hands, dependent: :destroy
  has_many :user_supports, dependent: :destroy
  belongs_to :game
  belongs_to_active_hash :character, class_name: 'Character', inverse_of: :users

  validates :character_id, presence: true

  enum role: {
    host: 1,
    guest: 2,
    spectator: 3,
  }, _suffix: true
  
  attr_accessor :user_token

  def authenticated?(session)
    taken? && BCrypt::Password.new(user_token_digest).is_password?(session[:user_token])
  end

  def set_user_token
    user_token = generate_user_token
    user_token_digest = generate_user_token_digest(user_token)
    assign_attributes(user_token:, user_token_digest:)
  end

  def taken? = user_token_digest.present?

  def set_hand!(character)
    case character
    when 'ヒポグリフ'
      user_hands.create!(hand_id: [1, 3].sample)
    when 'ユバの民'
      user_hands.create!(hand_id: [2, 3].sample)
    when 'カーバンクル'
      user_hands.create!(hand_id: [1, 2].sample)
    end
  end

  def set_support! = user_supports.create!(support: Support.all.sample)

  def enemy
    if host_role?
      game.guest
    else
      game.host
    end
  end

  def update_by_support_card!(support_card_id)
    user_hand = user_hands.sample
    enemy_hand = enemy.user_hands.sample
    user_hand_marshal = Marshal.load(Marshal.dump(user_hand)) # 破壊的変更があった場合にも、独立して値を保持できる
    enemy_hand_marshal = Marshal.load(Marshal.dump(enemy_hand))

    if support_card_id.to_i == 1
      hand_ids = Hand.all.pluck(:id)
      hand_ids.delete(user_hand_marshal.hand_id.to_i)
      UserHand.find(user_hand_marshal.id).update!(hand_id: hand_ids.sample)
    elsif support_card_id.to_i == 2
      UserHand.find(user_hand_marshal.id).update!(hand_id: enemy_hand_marshal.hand_id)
      UserHand.find(enemy_hand_marshal.id).update!(hand_id: user_hand_marshal.hand_id)
    elsif support_card_id.to_i == 3
      game.update!(field: Field.all.sample)
    end
  end

  def win?(user_hand:, enemy_hand:)
    if user_hand == 1 && enemy_hand == 3
      true
    elsif user_hand == 2 && enemy_hand == 1
      true
    elsif user_hand == 3 && enemy_hand == 2
      true
    else
      false
    end
  end

  def win_score
    win_score = 1
    case character.id
    when 1
      win_score = 2 if [1,2,3].include?(game.field.id)
    when 2
      win_score = 2 if [4,5,6].include?(game.field.id)
    when 3
      win_score = 2 if [7,8,9].include?(game.field.id)
    end
    win_score
  end

  def lose_score
    lose_score = 1
    case character.id
    when 1
      lose_score = 2 if [2,5,8].include?(game.field.id)
    when 2
      lose_score = 2 if [3,6,9].include?(game.field.id)
    when 3
      lose_score = 2 if [1,4,7].include?(game.field.id)
    end
    lose_score
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
