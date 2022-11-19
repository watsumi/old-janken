# == Schema Information
#
# Table name: game_details
#
#  id          :bigint           not null, primary key
#  round_score :integer
#  turn        :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  game_id     :uuid
#  hand_id     :integer
#  support_id  :integer
#  user_id     :uuid
#
# Indexes
#
#  index_game_details_on_game_id  (game_id)
#  index_game_details_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#  fk_rails_...  (user_id => users.id)
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
