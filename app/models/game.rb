class Game < ApplicationRecord
  include ActionView::RecordIdentifier
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  has_many :users, dependent: :destroy
  has_many :game_details, dependent: :destroy
  belongs_to_active_hash :field, class_name: 'Field', inverse_of: :games

  validates :field_id, presence: true

  after_update_commit do
    broadcast_replace_to self, target: self, partial: 'games/game_frame', locals: { game: self }
  end

  def notify_to_game(message)
    broadcast_update_to dom_id(self, "flashes"), target: 'flash', partial: "flash", locals: { message: }
  end

  def show_detail_modal_to_game(host_game_detail, guest_game_detail)
    broadcast_update_to dom_id(self, "detail"), target: "detail_modal", partial: "detail_modal", locals: { host_game_detail:, guest_game_detail: }
  end

  def show_finish_modal_to_game(game_details)
    broadcast_update_to dom_id(self, "finish"), target: "finish_modal", partial: "finish_modal", locals: { game_details: }
  end

  def winner_role
    win_user = users.find_by(id: winner)
    if win_user.present?
      "#{win_user.role}の勝利です！"
    else
      '引き分けです。'
    end
  end

  def host = @host ||= users.find_by(role: :host)

  def guest = @guest ||= users.find_by(role: :guest)

  def create_game_and_set_user_cards!
    return unless valid?
    save
    set_user_cards!
    game_details.create!(user_id: host.id, turn: :host_turn_1)
  end

  def turn_end!
    unless game_details.last.finished?
      if game_details.last.host_turn?
        game_details.create!(user_id: guest.id, turn: game_details.last.turn_before_type_cast+1)
      elsif game_details.last.guest_turn?
        game_details.create!(user_id: host.id, turn: game_details.last.turn_before_type_cast+1)
        round_judge!
      end
    end

    game_judge! if game_details.last.finished?
  end

  def round_judge!
    host_game_detail = game_details.where(user_id: host.id).second_to_last()
    guest_game_detail = game_details.where(user_id: guest.id).last

    calc_round_score(host_game_detail:, guest_game_detail:, role: :host)
    calc_round_score(host_game_detail:, guest_game_detail:, role: :guest)

    host_game_detail.save!
    guest_game_detail.save!
    show_detail_modal_to_game(host_game_detail, guest_game_detail)
  end

  def game_judge!
    host_game_details = game_details.where(user_id: host.id)
    guest_game_details = game_details.where(user_id: guest.id)

    winner = decide_winner(host_game_details:, guest_game_details:)
    update!(winner: winner)
    show_finish_modal_to_game(GameDetail.where(game_id: id).order(:created_at).limit(6))
  end

  private

  def set_user_cards!
    users.each do |user|
      3.times do
        user.set_hand!(user.character.name)
      end
      user.set_support!
    end
  end

  def calc_round_score(host_game_detail:, guest_game_detail:, role:)
    host_win_score = host.win_score
    guest_win_score = guest.win_score
    host_lose_score = host.lose_score
    guest_lose_score = guest.lose_score

    host_game_detail.round_score = 0
    guest_game_detail.round_score = 0

    if host.win?(user_hand: host_game_detail.hand_id, enemy_hand: guest_game_detail.hand_id)
      host_game_detail.round_score += host_win_score
      guest_game_detail.round_score -= guest_lose_score
    elsif guest.win?(user_hand: guest_game_detail.hand_id, enemy_hand: host_game_detail.hand_id)
      guest_game_detail.round_score = guest_win_score
      host_game_detail.round_score = host_lose_score
    end
  end

  def sum_round_scores(game_details)
    game_details.map do |game_detail|
      game_detail.round_score
    end.compact.sum
  end

  def decide_winner(host_game_details:, guest_game_details:)
    sum_host_scores = sum_round_scores(host_game_details)
    sum_guest_scores = sum_round_scores(guest_game_details)
    if sum_host_scores > sum_guest_scores
      host.id
    elsif sum_host_scores < sum_guest_scores
      guest.id
    else
      0
    end
  end
end
