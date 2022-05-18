require 'rails_helper'

RSpec.describe GameDetailsController, type: :routing do
  describe 'routing' do
    it 'GET games/1/game_details' do
      expect(get: 'games/1/game_details').to route_to(
        controller: 'game_details',
        action: 'index',
        game_id: '1',
      )
    end
  end
end
