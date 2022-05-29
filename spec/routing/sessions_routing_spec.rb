require 'rails_helper'

RSpec.describe Dev::UserSessionsController, type: :routing do
  describe 'routing' do
    it 'GET /login_as' do
      expect(get: '/login_as/1?game_id=1').to route_to(
        controller: 'dev/user_sessions',
        action: 'login_as',
        game_id: '1',
        user_id: '1',
      )
    end
  end
end
