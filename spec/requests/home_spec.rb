require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'GET /' do
    it 'renders a successful response' do
      get root_path
      expect(response).to be_successful
    end
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get home_path
      expect(response).to be_successful
    end
  end
end
