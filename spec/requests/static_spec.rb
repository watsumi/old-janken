require 'rails_helper'

RSpec.describe "Statics", type: :request do
  describe 'GET /credit' do
    it 'renders a successful response' do
      get credits_path
      expect(response).to be_successful
    end
  end

  describe 'GET /privacy_policy' do
    it 'renders a successful response' do
      get privacy_policy_path
      expect(response).to be_successful
    end
  end

  describe 'GET /rules' do
    it 'renders a successful response' do
      get rules_path
      expect(response).to be_successful
    end
  end

  describe 'GET /terms' do
    it 'renders a successful response' do
      get terms_path
      expect(response).to be_successful
    end
  end
end
