require 'rails_helper'

RSpec.describe UsersController, type: :routing do
  describe 'routing' do
    it 'GET /users/1' do
      expect(get: '/users/1').to route_to(
        controller: 'users',
        action: 'show',
        id: '1',
      )
    end
    it 'GET /users/1/edit/' do
      expect(get: '/users/1/edit').to route_to(
        controller: 'users',
        action: 'edit',
        id: '1',
      )
    end
    it 'POST /users/1/authorize/' do
      expect(post: '/users/1/authorize').to route_to(
        controller: 'users',
        action: 'authorize',
        user_id: '1',
      )
    end
  end
end
