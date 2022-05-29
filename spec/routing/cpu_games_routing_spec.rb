require 'rails_helper'

RSpec.describe CpuGamesController, type: :routing do
  describe 'routing' do
    it 'GET /cpu_games/1' do
      expect(get: '/cpu_games/1').to route_to(
        controller: 'cpu_games',
        action: 'show',
        id: '1',
      )
    end
    it 'POST /cpu_games' do
      expect(post: '/cpu_games').to route_to(
        controller: 'cpu_games',
        action: 'create',
      )
    end
    it 'DELETE /cpu_games/1' do
      expect(delete: '/cpu_games/1').to route_to(
        controller: 'cpu_games',
        action: 'destroy',
        id: '1',
      )
    end
  end
end
