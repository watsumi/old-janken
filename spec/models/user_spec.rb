# == Schema Information
#
# Table name: users
#
#  id                :uuid             not null, primary key
#  nickname          :string           default(""), not null
#  user_token_digest :string           default(""), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  character_id      :integer          default(1), not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create_anonymously!' do
    subject { User.create_anonymously! }

    it 'user_token_digestが生成され、userが作成されること' do
      subject
      expect(User.last.nickname).to eq('')
      expect(User.last.user_token_digest).to be_a_kind_of(String)
      expect(User.last.character_id).to eq(1)
    end
  end

  describe '#authenticated?' do
    let(:user) do
      create(:user, user_token_digest: BCrypt::Password.create('user_token', cost: BCrypt::Engine::MIN_COST))
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
