require 'rails_helper'

RSpec.describe 'UserHands', type: :request do
  let(:game) { create(:game) }
  let(:host)  { create(:user, game:, role: :host) }
  let(:guest) { create(:user, game:, role: :guest) }
  let!(:host_support) { create(:user_support, user: host) }
  let!(:host_hand) { create(:user_hand, user: host) }
  let!(:guest_hand) { create(:user_hand, user: guest) }
  let!(:game_details) do
    create(:game_detail, game:, user: host, hand_id: 1, turn: :host_turn1)
    create(:game_detail, game:, user: guest, hand_id: 2, turn: :guest_turn1)
    create(:game_detail, game:, user: host, hand_id: 1, turn: :host_turn2)
  end

  before { login_as(host) }

  describe 'GET /show/:id' do
    it 'renders a successful response' do
      get user_hand_path(host_hand, game_id: game.id)
      expect(response).to be_successful
    end
  end

  describe 'GET /edit/:id/edit' do
    it 'renders a successful response' do
      get edit_user_hand_path(host_hand, game_id: game.id)
      expect(response).to be_successful
    end
  end

  describe 'DELETE /user_hand_path/:id' do
    it 'renders a successful response' do
      delete user_hand_path(host_hand, game_id: game.id)
      expect(response).to redirect_to(game_path(game))
    end
  end
end
