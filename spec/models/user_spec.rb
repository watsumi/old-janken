# == Schema Information
#
# Table name: users
#
#  id                :uuid             not null, primary key
#  role              :integer          not null
#  user_token_digest :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  character_id      :integer          not null
#  game_id           :string           not null
#  support_id        :string           not null
#
# Indexes
#
#  index_users_on_game_id_and_role  (game_id,role) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:game) { create(:game) }

  describe '#update_user_token!' do
    let(:host) { build(:user, game:, role: 'host') }
    subject { host.update_user_token! }

    it 'user_token_digestが更新されること' do
      subject
      expect(User.last.user_token_digest).to be_a_kind_of(String)
      expect(User.last.character_id).to eq(1)
    end
  end

  describe '#authenticated?' do
    let(:user) do
      create(:user, game:,
                    user_token_digest: BCrypt::Password.create('user_token', cost: BCrypt::Engine::MIN_COST))
    end
    subject { user.authenticated?(user_token) }

    context 'user_tokenが正しい値のとき' do
      let(:user_token) { 'user_token' }
      it { expect(subject).to eq(true) }
    end

    context 'user_tokenが不正な値のとき' do
      let(:user_token) { 'invalid_user_token' }
      it { expect(subject).to eq(false) }
    end
  end
end
