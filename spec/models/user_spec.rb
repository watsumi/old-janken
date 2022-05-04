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

  describe '#set_user_token' do
    let(:host) { build(:user, game:, role: 'host') }
    subject { host.set_user_token; game.save! }

    it 'user_token_digestが追加されること' do
      expect{ subject }.to change{
        host.user_token_digest }.from(nil).to(be_a_kind_of(String))
    end
  end

  describe '#authenticated?' do
    let(:user) do
      create(:user, game:,
                    role: :host,
                    user_token_digest: BCrypt::Password.create('user_token', cost: BCrypt::Engine::MIN_COST))
    end
    subject { user.authenticated?({user_token: user_token}) }

    context 'user_tokenが正しい値のとき' do
      let(:user_token) { 'user_token' }
      it { expect(subject).to eq(true) }
    end

    context 'user_tokenが不正な値のとき' do
      let(:user_token) { 'invalid_user_token' }
      it { expect(subject).to eq(false) }
    end
  end

  describe '#set_hand!' do
    let!(:user) do
      create(:user, game:,
                    role: :host,
                    character_id: character.id)
    end
    let(:hippogriff) { Character.find(1) }
    let(:yuba) { Character.find(2) }
    let(:carbuncle) { Character.find(3) }

    subject { user.set_hand!(character.name) }

    context 'ヒポグリフのとき' do
      let(:character) { hippogriff }
      it 'グーまたはチョキが選ばれること' do
        subject
        expect(user.user_hands.first.hand_id).to eq("1").or eq("3")
      end
    end
    context 'ユバのとき' do
      let(:character) { yuba }
      it 'グーまたはチョキが選ばれること' do
        subject
        expect(user.user_hands.first.hand_id).to eq("2").or eq("3")
      end
    end
    context 'カーバンクルのとき' do
      let(:character) { carbuncle }
      it 'グーまたはチョキが選ばれること' do
        subject
        expect(user.user_hands.first.hand_id).to eq("1").or eq("2")
      end
    end
  end
end
