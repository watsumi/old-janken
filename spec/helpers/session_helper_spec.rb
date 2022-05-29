require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:game) { create(:game) }
  let(:user) { create(:user, game:, role: :host) }

  describe '#remember' do
    subject { helper.remember(user) }

    context '正常系' do
      before { user.set_user_token }

      it 'sessionにuser_id/user_tokenが保持されること' do
        subject
        expect(session[:user_id]).to eq(user.id)
        expect(session[:user_token]).to eq(user.user_token)
      end
    end
  end

  describe '#current_user' do
    subject { helper.current_user }

    context '正常系' do
      before do
        user.set_user_token
        user.save!
        remember(user)
      end

      specify do
        is_expected.to eq(user)
      end
    end

    context '異常系' do
      specify 'sessionにuser情報が保持されていないとき,nilが返ること' do
        is_expected.to eq(nil)
      end
    end
  end
end
