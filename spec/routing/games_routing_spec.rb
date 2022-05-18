require 'rails_helper'

RSpec.describe GamesController, type: :routing do
  describe 'routing' do
    it 'GET /games' do
      expect(get: '/games').to route_to(
        controller: 'games',
        action: 'index'
      )
    end
    it 'GET /games/1' do
      expect(get: '/games/1').to route_to(
        controller: 'games',
        action: 'show',
        id: '1',
      )
    end
    it 'POST /games' do
      expect(post: '/games').to route_to(
        controller: 'games',
        action: 'create',
      )
    end
    it 'DELETE /games/1' do
      expect(delete: '/games/1').to route_to(
        controller: 'games',
        action: 'destroy',
        id: '1',
      )
    end
  end
end
