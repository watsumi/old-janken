require 'rails_helper'

RSpec.describe '/games', type: :request do
  describe 'POST create' do
    context '実行したとき' do
      it 'redirect' do
        post '/games'
        game = Game.first
        expect(response).to redirect_to("/games/#{game.id}/host")
      end
    end
  end
end
