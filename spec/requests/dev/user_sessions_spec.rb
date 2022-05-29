require 'rails_helper'

RSpec.describe "Dev::UserSessions", type: :request do
  let!(:game) { create(:game) }
  let!(:host) { create(:user, game:, role: :host, character: Character.all.sample) }

  describe "GET /login_as/1?game_id=1" do
    it 'renders a successful response' do
      get "/login_as/#{host.id}?game_id=#{game.id}"
      expect(response).to redirect_to(game_path(game))
    end
  end
end
