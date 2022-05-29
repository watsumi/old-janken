require 'rails_helper'

RSpec.describe '/games', type: :request do
  let(:game) { create(:game) }
  let(:host) { create(:user, game:, role: :host, character: Character.all.sample) }
  let(:guest) { create(:user, game:, role: :guest, character: Character.all.sample) }
  let!(:host_game_detail) { create_list(:game_detail, 3, game:, user: host) }
  let!(:guest_game_detail) { create_list(:game_detail, 3, game:, user: guest) }

  before do
    login_as(host)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get games_path
      expect(response).to be_successful
    end
  end
  describe 'GET /show' do
    let(:game) { create(:game) }
    it 'renders a successful response' do
      get game_url(game)
      expect(response).to be_successful
    end
  end
end
