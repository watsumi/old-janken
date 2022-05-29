require 'rails_helper'

RSpec.describe 'GameDetails', type: :request do
  let(:game) { create(:game) }
  let!(:game_detail) { create_list(:game_detail, 6, game:, user:) }
  let(:user) { create(:user, game:, role: :host) }

  before { login_as(user) }

  describe 'GET /index' do
    it 'renders a successful response' do
      get game_game_details_path(game_id: game.id)
      expect(response).to be_successful
    end
  end
end
