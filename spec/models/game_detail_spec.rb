# == Schema Information
#
# Table name: games
#
#  id         :uuid             not null, primary key
#  winner     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  field_id   :integer          default(1), not null
#
require 'rails_helper'

RSpec.describe GameDetail, type: :model do
  include ActionView::RecordIdentifier

  let!(:game)  { create(:game) }
  let!(:host)  { create(:user, game:, role: :host) }
  let!(:guest) { create(:user, game:, role: :guest) }

  describe '#host_turn?' do
    let(:game_detail) { create(:game_detail, game:, turn: :host_turn1, user: host) }

    subject { game_detail.host_turn? }

    context '正常系' do
      it 'trueが返ること' do
        expect(subject).to be_truthy
      end
    end
  end

  describe '#guest_turn?' do
    let(:game_detail) { create(:game_detail, game:, turn: :guest_turn1, user: guest) }

    subject { game_detail.guest_turn? }

    context '正常系' do
      it 'trueが返ること' do
        expect(subject).to be_truthy
      end
    end
  end

  describe '#round_num' do
    let(:game_detail) { create(:game_detail, game:, turn: :guest_turn1, user: guest) }

    subject { game_detail.round_num }

    context '正常系' do
      specify do
        is_expected.to eq('Round 1')
      end
    end
  end
end
