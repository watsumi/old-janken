require 'rails_helper'

RSpec.describe '/users', type: :request do
  let(:game) { create(:game) }
  let(:host)  { create(:user, game:, role: :host) }
  let(:guest) { create(:user, game:, role: :guest) }
  let!(:game_details) do
    create(:game_detail, game:, user: host, hand_id: 1, turn: :host_turn_1)
    create(:game_detail, game:, user: guest, hand_id: 2, turn: :guest_turn_1)
    create(:game_detail, game:, user: host, hand_id: 1, turn: :host_turn_2)
  end

  before { login_as(host) }

  describe 'GET /edit/:user_id' do
    it 'renders a successful response' do
      get edit_user_path(host)
      expect(response).to be_successful
    end
  end

  describe 'POST /users/:user_id/authorize' do
    it 'renders a successful response' do
      post user_authorize_path(host, game_id: game.id)
      expect(response).to redirect_to(game_path(game))
    end
  end
end
