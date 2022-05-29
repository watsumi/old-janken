require 'rails_helper'

RSpec.describe UserSupportsController, type: :routing do
  describe 'routing' do
    it 'GET /user_supports/1/edit/' do
      expect(get: '/user_supports/1/edit').to route_to(
        controller: 'user_supports',
        action: 'edit',
        id: '1',
      )
    end
    it 'DELETE /user_supports/1' do
      expect(delete: '/user_supports/1').to route_to(
        controller: 'user_supports',
        action: 'destroy',
        id: '1',
      )
    end
  end
end
