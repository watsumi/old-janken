require 'rails_helper'

RSpec.describe UserHandsController, type: :routing do
  describe 'routing' do
    it 'GET /user_hands/1' do
      expect(get: '/user_hands/1').to route_to(
        controller: 'user_hands',
        action: 'show',
        id: '1',
      )
    end
    it 'GET /user_hands/1/edit/' do
      expect(get: '/user_hands/1/edit').to route_to(
        controller: 'user_hands',
        action: 'edit',
        id: '1',
      )
    end
    it 'DELETE /user_hands/1' do
      expect(delete: '/user_hands/1').to route_to(
        controller: 'user_hands',
        action: 'destroy',
        id: '1',
      )
    end
  end
end
