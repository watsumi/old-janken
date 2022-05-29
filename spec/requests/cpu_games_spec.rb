require 'rails_helper'

RSpec.describe 'CpuGames', type: :request do
  let(:game) { create(:game) }
  let(:host) { create(:user, game:, role: :host, character: Character.all.sample) }
  let(:guest) { create(:user, game:, role: :guest, character: Character.all.sample) }
  let!(:host_game_detail) { create_list(:game_detail, 3, game:, user: host) }
  let!(:guest_game_detail) { create_list(:game_detail, 3, game:, user: guest) }

  before do
    login_as(host)
  end

  describe 'GET /show' do
    let(:game) { create(:game) }
    it 'renders a successful response' do
      get cpu_game_url(game)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    it 'creates a new cpu_game' do
      expect { post cpu_games_url }.to change(Game, :count).by(1)
    end
  end
end
