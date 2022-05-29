require 'rails_helper'

RSpec.describe 'CpuGames', type: :request do
  describe 'GET /index' do
    it 'renders a successful response' do
      get games_path
      expect(response).to be_successful
    end
  end
end
