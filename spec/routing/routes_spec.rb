# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routing test', type: :routing do
  it 'GET /' do
    expect(get: '/').to route_to(
      controller: 'static',
      action: 'index'
    )
  end
  it 'GET /terms' do
    expect(get: '/terms').to route_to(
      controller: 'static',
      action: 'terms',
    )
  end
  it 'GET /rules' do
    expect(get: '/rules').to route_to(
      controller: 'static',
      action: 'rules',
    )
  end
  it 'GET /credits' do
    expect(get: '/credits').to route_to(
      controller: 'static',
      action: 'credits',
    )
  end
  it 'GET /privacy_policy' do
    expect(get: '/privacy_policy').to route_to(
      controller: 'static',
      action: 'privacy_policy',
    )
  end
end
